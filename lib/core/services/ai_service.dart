import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'nutrition_service.dart';
import 'ai_prompt_service.dart';

part 'ai_service.g.dart';

abstract class AIService {
  Future<String> generateResponse(String prompt, List<Map<String, String>> context);
  Future<Map<String, dynamic>?> analyzeFood(String foodDescription);
  Future<Map<String, dynamic>?> extractFoodData(String userMessage);
  Future<Map<String, dynamic>?> analyzeFoodWithQuantity(String foodName, double quantity, String unit);
}

class OpenAIService implements AIService {
  final String apiKey;
  final String endpoint;
  final Dio _dio;
  final NutritionService nutritionService;
  final String systemPrompt;

  OpenAIService({
    required this.apiKey,
    required this.endpoint,
    required this.nutritionService,
    required this.systemPrompt,
  }) : _dio = Dio();

  @override
  Future<String> generateResponse(String prompt, List<Map<String, String>> context) async {
    try {
      final messages = [
        {
          "role": "system",
          "content": systemPrompt,
        },
        ...context,
        {"role": "user", "content": prompt}
      ];

      final response = await _dio.post(
        '$endpoint/chat/completions',
        data: {
          'model': 'gpt-4o-mini',
          'messages': messages,
          'temperature': 0.7,
          'max_tokens': 500,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.data['choices'][0]['message']['content'];
    } catch (e) {
      throw Exception('Failed to generate AI response: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> analyzeFood(String foodDescription) async {
    try {
      // Search for food using NutritionService (USDA + Open Food Facts)
      final results = await nutritionService.searchFood(foodDescription);

      if (results.isEmpty) {
        return null;
      }

      // Get the first result's details
      final firstResult = results.first;
      final details = await nutritionService.getFoodDetails(firstResult.id);

      if (details == null) return null;

      // Use the first serving (100g default)
      final serving = details.servings.isNotEmpty ? details.servings.first : null;

      return {
        'name': details.name,
        'calories': serving?.calories ?? details.calories,
        'protein': serving?.protein ?? details.protein,
        'carbs': serving?.carbs ?? details.carbs,
        'fat': serving?.fat ?? details.fat,
        'serving_description': serving?.description ?? '100g',
      };
    } catch (e) {
      print('Error analyzing food: $e');
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> extractFoodData(String userMessage) async {
    try {
      final response = await _dio.post(
        '$endpoint/chat/completions',
        data: {
          'model': 'gpt-4o-mini',
          'messages': [
            {
              "role": "system",
              "content": AIPromptService.foodExtractionPrompt,
            },
            {"role": "user", "content": userMessage}
          ],
          'temperature': 0.3, // Lower temperature for more consistent JSON
          'max_tokens': 500,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ),
      );

      final content = response.data['choices'][0]['message']['content'] as String;

      // Parse JSON from response (handle potential markdown code blocks)
      String jsonStr = content.trim();
      if (jsonStr.startsWith('```json')) {
        jsonStr = jsonStr.substring(7);
      } else if (jsonStr.startsWith('```')) {
        jsonStr = jsonStr.substring(3);
      }
      if (jsonStr.endsWith('```')) {
        jsonStr = jsonStr.substring(0, jsonStr.length - 3);
      }
      jsonStr = jsonStr.trim();

      return jsonDecode(jsonStr) as Map<String, dynamic>;
    } catch (e) {
      print('Error extracting food data: $e');
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> analyzeFoodWithQuantity(
    String foodName,
    double quantity,
    String unit,
  ) async {
    try {
      print('🔍 Nutrition search: "$foodName" (qty: $quantity $unit)');

      // Search for food using NutritionService (USDA + Open Food Facts)
      var results = await nutritionService.searchFood(foodName);
      print('📊 Results for "$foodName": ${results.length} items');

      // If no results, try alternative search terms
      if (results.isEmpty) {
        final alternatives = _getAlternativeSearchTerms(foodName);
        for (final alt in alternatives) {
          print('🔄 Trying alternative: "$alt"');
          results = await nutritionService.searchFood(alt);
          if (results.isNotEmpty) {
            print('✅ Found with alternative: "$alt" (${results.length} items)');
            break;
          }
        }
      }

      if (results.isEmpty) {
        print('❌ No results found for "$foodName" or alternatives');
        return null;
      }

      // Get the first result's details
      final firstResult = results.first;
      final details = await nutritionService.getFoodDetails(firstResult.id);

      if (details == null) {
        print('❌ Could not get details for ${firstResult.id}');
        return null;
      }

      // Find the best matching serving based on unit
      ServingInfo? bestServing;
      double multiplier = 1.0;

      // Nutrition data is per 100g, so we need to calculate based on quantity
      if (unit == 'g') {
        // User specified grams - use per 100g data
        multiplier = quantity / 100;
        bestServing = details.servings.firstWhere(
          (s) => s.description == '100g',
          orElse: () => details.servings.first,
        );
      } else if (unit == 'ml') {
        // For liquids, assume 1ml = 1g approximately
        multiplier = quantity / 100;
        bestServing = details.servings.first;
      } else {
        // For other units (slice, cup, unit, portion), try to find matching serving
        for (final serving in details.servings) {
          final desc = serving.description.toLowerCase();

          if (unit == 'slice' && desc.contains('slice')) {
            bestServing = serving;
            multiplier = quantity;
            break;
          }
          if (unit == 'cup' && desc.contains('cup')) {
            bestServing = serving;
            multiplier = quantity;
            break;
          }
          if ((unit == 'unit' || unit == 'piece') &&
              (desc.contains('medium') || desc.contains('large') ||
               desc.contains('small') || desc.contains('whole') ||
               desc.contains('1 ') || desc.contains('serving'))) {
            bestServing = serving;
            multiplier = quantity;
            break;
          }
          if (unit == 'portion' && desc.contains('serving')) {
            bestServing = serving;
            multiplier = quantity;
            break;
          }
        }

        // If no matching serving found, use 100g as base and estimate
        if (bestServing == null) {
          bestServing = details.servings.first;
          multiplier = quantity; // Assume quantity units
        }
      }

      // Calculate nutrition based on multiplier
      final calories = (bestServing.calories) * multiplier;
      final protein = (bestServing.protein) * multiplier;
      final carbs = (bestServing.carbs) * multiplier;
      final fat = (bestServing.fat) * multiplier;

      return {
        'name': details.name,
        'calories': calories,
        'protein': protein,
        'carbs': carbs,
        'fat': fat,
        'quantity': quantity,
        'unit': unit,
        'serving_description': bestServing.description,
        'source': details.source,
      };
    } catch (e) {
      print('Error analyzing food with quantity: $e');
      return null;
    }
  }

  /// Get alternative search terms for a food name
  /// Helps find foods when the direct translation doesn't work in FatSecret
  List<String> _getAlternativeSearchTerms(String foodName) {
    final lower = foodName.toLowerCase();

    // Map of common foods to alternative search terms
    final alternatives = <String, List<String>>{
      'toast': ['toasted bread', 'bread toast', 'white bread', 'wheat bread'],
      'rice': ['white rice', 'cooked rice', 'steamed rice'],
      'chicken': ['chicken breast', 'grilled chicken', 'roasted chicken'],
      'eggs': ['egg', 'whole egg', 'fried egg', 'scrambled egg'],
      'egg': ['whole egg', 'fried egg', 'boiled egg'],
      'beans': ['black beans', 'pinto beans', 'kidney beans', 'cooked beans'],
      'butter': ['salted butter', 'unsalted butter', 'margarine'],
      'milk': ['whole milk', 'skim milk', '2% milk'],
      'bread': ['white bread', 'wheat bread', 'whole grain bread'],
      'cheese': ['cheddar cheese', 'mozzarella', 'american cheese'],
      'beef': ['ground beef', 'beef steak', 'lean beef'],
      'pork': ['pork chop', 'pork loin', 'ground pork'],
      'fish': ['salmon', 'tilapia', 'cod', 'white fish'],
      'pasta': ['spaghetti', 'penne', 'cooked pasta'],
      'potato': ['baked potato', 'mashed potato', 'boiled potato'],
      'salad': ['green salad', 'mixed greens', 'lettuce'],
      'juice': ['orange juice', 'apple juice', 'fruit juice'],
      'coffee': ['black coffee', 'brewed coffee', 'espresso'],
      'tea': ['black tea', 'green tea', 'herbal tea'],
      'yogurt': ['plain yogurt', 'greek yogurt', 'low fat yogurt'],
      'apple': ['raw apple', 'fresh apple', 'apple fruit'],
      'banana': ['raw banana', 'fresh banana', 'banana fruit'],
      'orange': ['raw orange', 'fresh orange', 'orange fruit'],
      // Japanese foods
      'rice ball': ['onigiri', 'japanese rice ball', 'rice triangle'],
      'fried chicken': ['karaage', 'chicken karaage', 'japanese fried chicken'],
      // More specific terms
      'grilled chicken breast': ['chicken breast grilled', 'boneless chicken breast'],
    };

    // Return alternatives if they exist, or try generic variations
    if (alternatives.containsKey(lower)) {
      return alternatives[lower]!;
    }

    // Generate generic alternatives
    return [
      '$foodName raw',
      '$foodName cooked',
      'fresh $foodName',
      '$foodName generic',
    ];
  }
}

class MockAIService implements AIService {
  final NutritionService? nutritionService;
  final String systemPrompt;

  MockAIService({this.nutritionService, required this.systemPrompt});

  @override
  Future<String> generateResponse(String prompt, List<Map<String, String>> context) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (prompt.toLowerCase().contains('caloria') || 
        prompt.toLowerCase().contains('calories') ||
        prompt.toLowerCase().contains('macro')) {
      return "WIDGET:daily_summary";
    }
    
    return "Entendi que você comeu: $prompt. Quer adicionar mais alguma informação?";
  }

  @override
  Future<Map<String, dynamic>?> analyzeFood(String foodDescription) async {
    if (nutritionService != null) {
      try {
        final results = await nutritionService!.searchFood(foodDescription);
        if (results.isNotEmpty) {
          final details = await nutritionService!.getFoodDetails(results.first.id);
          if (details != null) {
            return {
              'name': details.name,
              'calories': details.calories,
              'protein': details.protein,
              'carbs': details.carbs,
              'fat': details.fat,
            };
          }
        }
      } catch (e) {
        print('Nutrition service error in mock: $e');
      }
    }

    await Future.delayed(const Duration(seconds: 1));
    if (foodDescription.toLowerCase().contains("egg") ||
        foodDescription.toLowerCase().contains("ovo")) {
      return {
        'calories': 155,
        'protein': 13,
        'carbs': 1,
        'fat': 11,
      };
    }
    return null;
  }

  @override
  Future<Map<String, dynamic>?> extractFoodData(String userMessage) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final lowerMessage = userMessage.toLowerCase();

    // Simple mock extraction - check for common food patterns
    if (lowerMessage.contains('olá') ||
        lowerMessage.contains('oi') ||
        lowerMessage.contains('bom dia') ||
        lowerMessage.contains('ajuda') ||
        lowerMessage.contains('?')) {
      return {'is_food_log': false};
    }

    // Detect meal type
    String? mealType;
    if (lowerMessage.contains('café') ||
        lowerMessage.contains('breakfast') ||
        lowerMessage.contains('manhã')) {
      mealType = 'breakfast';
    } else if (lowerMessage.contains('almoço') ||
               lowerMessage.contains('almocei') ||
               lowerMessage.contains('lunch')) {
      mealType = 'lunch';
    } else if (lowerMessage.contains('jantar') ||
               lowerMessage.contains('jantei') ||
               lowerMessage.contains('dinner')) {
      mealType = 'dinner';
    } else if (lowerMessage.contains('lanche') ||
               lowerMessage.contains('snack')) {
      mealType = 'snack';
    }

    // Simple food detection (mock)
    final List<Map<String, dynamic>> foods = [];

    if (lowerMessage.contains('ovo') || lowerMessage.contains('egg')) {
      foods.add({'name': 'egg', 'quantity': 1, 'unit': 'unit', 'original_name': 'ovo'});
    }
    if (lowerMessage.contains('torrada') || lowerMessage.contains('toast')) {
      foods.add({'name': 'toast', 'quantity': 1, 'unit': 'slice', 'original_name': 'torrada'});
    }
    if (lowerMessage.contains('arroz') || lowerMessage.contains('rice')) {
      foods.add({'name': 'rice', 'quantity': 1, 'unit': 'portion', 'original_name': 'arroz'});
    }
    if (lowerMessage.contains('feijão') || lowerMessage.contains('beans')) {
      foods.add({'name': 'beans', 'quantity': 1, 'unit': 'portion', 'original_name': 'feijão'});
    }

    if (foods.isEmpty) {
      return {'is_food_log': false};
    }

    return {
      'is_food_log': true,
      'meal_type': mealType,
      'foods': foods,
    };
  }

  @override
  Future<Map<String, dynamic>?> analyzeFoodWithQuantity(
    String foodName,
    double quantity,
    String unit,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock nutrition data per 100g or per unit
    final Map<String, Map<String, double>> mockData = {
      'egg': {'calories': 155, 'protein': 13, 'carbs': 1, 'fat': 11},
      'toast': {'calories': 79, 'protein': 3, 'carbs': 15, 'fat': 1},
      'rice': {'calories': 130, 'protein': 2.7, 'carbs': 28, 'fat': 0.3},
      'beans': {'calories': 127, 'protein': 8.7, 'carbs': 22, 'fat': 0.5},
      'chicken': {'calories': 165, 'protein': 31, 'carbs': 0, 'fat': 3.6},
      'butter': {'calories': 717, 'protein': 0.9, 'carbs': 0.1, 'fat': 81},
    };

    final baseData = mockData[foodName.toLowerCase()] ??
        {'calories': 100, 'protein': 5, 'carbs': 10, 'fat': 5};

    double multiplier = quantity;
    if (unit == 'g') {
      multiplier = quantity / 100;
    }

    return {
      'name': foodName,
      'calories': baseData['calories']! * multiplier,
      'protein': baseData['protein']! * multiplier,
      'carbs': baseData['carbs']! * multiplier,
      'fat': baseData['fat']! * multiplier,
      'quantity': quantity,
      'unit': unit,
    };
  }
}

@riverpod
AIService aiService(Ref ref) {
  final nutritionService = ref.watch(nutritionServiceProvider);
  final aiPromptService = ref.watch(aiPromptServiceProvider);

  // Load API key from .env file (loaded in main.dart)
  final apiKey = dotenv.env['OPENAI_PROXY_API_KEY'] ?? '';
  final endpoint = dotenv.env['OPENAI_PROXY_ENDPOINT'] ?? 'https://api.openai.com/v1';

  // Use OpenAI service if API key is available, otherwise fallback to Mock
  if (apiKey.isNotEmpty) {
    return OpenAIService(
      apiKey: apiKey,
      endpoint: endpoint,
      nutritionService: nutritionService,
      systemPrompt: aiPromptService.systemPrompt,
    );
  }

  // Fallback to mock service when no API key available
  return MockAIService(nutritionService: nutritionService, systemPrompt: aiPromptService.systemPrompt);
}
