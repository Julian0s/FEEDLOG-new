import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'fatsecret_service.dart';
import 'ai_prompt_service.dart';

part 'ai_service.g.dart';

abstract class AIService {
  Future<String> generateResponse(String prompt, List<Map<String, String>> context);
  Future<Map<String, dynamic>?> analyzeFood(String foodDescription);
}

class OpenAIService implements AIService {
  final String apiKey;
  final String endpoint;
  final Dio _dio;
  final FatSecretService fatSecretService;
  final String systemPrompt;

  OpenAIService({
    required this.apiKey,
    required this.endpoint,
    required this.fatSecretService,
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
      // Search for food in FatSecret
      final results = await fatSecretService.searchFood(foodDescription);
      
      if (results.isEmpty) {
        return null;
      }

      // Get the first result's details
      final firstResult = results.first;
      final details = await fatSecretService.getFoodDetails(firstResult.foodId);
      
      // Parse serving information
      final servings = details['servings']?['serving'];
      if (servings == null) return null;
      
      final serving = servings is List ? servings.first : servings;
      
      return {
        'name': details['food_name'] ?? foodDescription,
        'calories': double.tryParse(serving['calories']?.toString() ?? '0') ?? 0,
        'protein': double.tryParse(serving['protein']?.toString() ?? '0') ?? 0,
        'carbs': double.tryParse(serving['carbohydrate']?.toString() ?? '0') ?? 0,
        'fat': double.tryParse(serving['fat']?.toString() ?? '0') ?? 0,
        'serving_description': serving['serving_description'],
      };
    } catch (e) {
      print('Error analyzing food: $e');
      return null;
    }
  }
}

class MockAIService implements AIService {
  final FatSecretService? fatSecretService;
  final String systemPrompt;

  MockAIService({this.fatSecretService, required this.systemPrompt});

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
    if (fatSecretService != null) {
      try {
        final results = await fatSecretService!.searchFood(foodDescription);
        if (results.isNotEmpty) {
          final details = await fatSecretService!.getFoodDetails(results.first.foodId);
          final servings = details['servings']?['serving'];
          if (servings != null) {
            final serving = servings is List ? servings.first : servings;
            return {
              'name': details['food_name'] ?? foodDescription,
              'calories': double.tryParse(serving['calories']?.toString() ?? '0') ?? 0,
              'protein': double.tryParse(serving['protein']?.toString() ?? '0') ?? 0,
              'carbs': double.tryParse(serving['carbohydrate']?.toString() ?? '0') ?? 0,
              'fat': double.tryParse(serving['fat']?.toString() ?? '0') ?? 0,
            };
          }
        }
      } catch (e) {
        print('FatSecret error in mock: $e');
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
}

@riverpod
AIService aiService(Ref ref) {
  // Toggle between OpenAI and Mock
  const useRealAPI = true; // Set to true to use OpenAI

  final fatSecretService = ref.watch(fatSecretServiceProvider);
  final aiPromptService = ref.watch(aiPromptServiceProvider);

  if (useRealAPI) {
    // Load from environment variables (set via --dart-define at build time)
    // Example: flutter run --dart-define=OPENAI_PROXY_API_KEY=sk-xxx
    const apiKey = String.fromEnvironment('OPENAI_PROXY_API_KEY');
    const endpoint = String.fromEnvironment('OPENAI_PROXY_ENDPOINT',
      defaultValue: 'https://api.openai.com/v1');

    return OpenAIService(
      apiKey: apiKey,
      endpoint: endpoint,
      fatSecretService: fatSecretService,
      systemPrompt: aiPromptService.systemPrompt,
    );
  }

  return MockAIService(fatSecretService: fatSecretService, systemPrompt: aiPromptService.systemPrompt);
}
