import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'nutrition_service.dart';

part 'usda_service.g.dart';

/// Servico para USDA FoodData Central API
/// Documentacao: https://fdc.nal.usda.gov/api-guide.html
///
/// Nutrient IDs importantes:
/// 1008 = Energy (kcal)
/// 1003 = Protein (g)
/// 1005 = Carbohydrate (g)
/// 1004 = Total Fat (g)
/// 1079 = Fiber (g)
/// 2000 = Sugars (g)
class UsdaService {
  final String apiKey;
  final Dio _dio;

  static const String _baseUrl = 'https://api.nal.usda.gov/fdc/v1';

  // Nutrient IDs
  static const int _energyId = 1008;
  static const int _proteinId = 1003;
  static const int _carbsId = 1005;
  static const int _fatId = 1004;

  UsdaService({required this.apiKey}) : _dio = Dio();

  /// Busca alimentos no USDA FoodData Central
  Future<List<FoodSearchResult>> searchFood(String query) async {
    if (apiKey.isEmpty) {
      print('USDA API key not configured');
      return [];
    }

    try {
      // Usar query parameter para API key em vez de header (melhor compatibilidade CORS)
      final response = await _dio.post(
        '$_baseUrl/foods/search?api_key=$apiKey',
        data: {
          'query': query,
          'pageSize': 20,
          'dataType': ['Foundation', 'SR Legacy', 'Branded'],
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      final foods = response.data['foods'] as List?;
      if (foods == null || foods.isEmpty) {
        return [];
      }

      return foods.map((food) {
        // Extrair calorias do preview
        double? caloriesPreview;
        final nutrients = food['foodNutrients'] as List?;
        if (nutrients != null) {
          for (final nutrient in nutrients) {
            if (nutrient['nutrientId'] == _energyId ||
                nutrient['nutrientNumber'] == '208') {
              caloriesPreview = (nutrient['value'] as num?)?.toDouble();
              break;
            }
          }
        }

        return FoodSearchResult(
          id: 'usda:${food['fdcId']}',
          name: food['description'] ?? food['lowercaseDescription'] ?? 'Unknown',
          brandName: food['brandName'] ?? food['brandOwner'],
          source: 'usda',
          caloriesPreview: caloriesPreview,
        );
      }).toList();
    } catch (e) {
      print('USDA search error: $e');
      return [];
    }
  }

  /// Obtem detalhes de um alimento especifico
  Future<FoodDetails?> getFoodDetails(String fdcId) async {
    if (apiKey.isEmpty) {
      print('USDA API key not configured');
      return null;
    }

    // Remove prefixo se existir
    final cleanId = fdcId.startsWith('usda:') ? fdcId.substring(5) : fdcId;

    try {
      // Usar query parameter para API key em vez de header (melhor compatibilidade CORS)
      final response = await _dio.get(
        '$_baseUrl/food/$cleanId?api_key=$apiKey',
      );

      final data = response.data;
      final nutrients = data['foodNutrients'] as List?;

      if (nutrients == null) {
        return null;
      }

      // Extrair nutrientes
      double calories = 0;
      double protein = 0;
      double carbs = 0;
      double fat = 0;

      for (final nutrient in nutrients) {
        final nutrientData = nutrient['nutrient'] ?? nutrient;
        final id = nutrientData['id'] ?? nutrient['nutrientId'];
        final number = nutrientData['number'] ?? nutrient['nutrientNumber'];
        final value = (nutrient['amount'] ?? nutrient['value'] as num?)?.toDouble() ?? 0;

        if (id == _energyId || number == '208') {
          calories = value;
        } else if (id == _proteinId || number == '203') {
          protein = value;
        } else if (id == _carbsId || number == '205') {
          carbs = value;
        } else if (id == _fatId || number == '204') {
          fat = value;
        }
      }

      // Criar servings baseado em porcoes disponiveis
      final servings = <ServingInfo>[];

      // Serving padrao de 100g
      servings.add(ServingInfo(
        description: '100g',
        grams: 100,
        calories: calories,
        protein: protein,
        carbs: carbs,
        fat: fat,
      ));

      // Adicionar porcoes especificas se disponiveis
      final portions = data['foodPortions'] as List?;
      if (portions != null) {
        for (final portion in portions) {
          final gramWeight = (portion['gramWeight'] as num?)?.toDouble();
          if (gramWeight != null && gramWeight > 0) {
            final multiplier = gramWeight / 100;
            servings.add(ServingInfo(
              description: portion['portionDescription'] ??
                          portion['modifier'] ??
                          '${gramWeight.round()}g',
              grams: gramWeight,
              calories: calories * multiplier,
              protein: protein * multiplier,
              carbs: carbs * multiplier,
              fat: fat * multiplier,
            ));
          }
        }
      }

      return FoodDetails(
        id: 'usda:$cleanId',
        name: data['description'] ?? 'Unknown',
        brandName: data['brandName'] ?? data['brandOwner'],
        calories: calories,
        protein: protein,
        carbs: carbs,
        fat: fat,
        servings: servings,
        source: 'usda',
      );
    } catch (e) {
      print('USDA details error: $e');
      return null;
    }
  }
}

@riverpod
UsdaService usdaService(Ref ref) {
  final apiKey = dotenv.env['USDA_API_KEY'] ?? '';
  return UsdaService(apiKey: apiKey);
}
