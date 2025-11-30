import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'nutrition_service.dart';

part 'open_food_facts_service.g.dart';

/// Servico para Open Food Facts API
/// Documentacao: https://openfoodfacts.github.io/openfoodfacts-server/api/
///
/// API 100% gratuita e sem necessidade de API key
/// 4M+ produtos de 150 paises
class OpenFoodFactsService {
  final Dio _dio;

  static const String _baseUrl = 'https://world.openfoodfacts.org';

  OpenFoodFactsService() : _dio = Dio();

  /// Parse valores numericos que podem vir como String ou num
  double _parseNumeric(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }

  /// Busca alimentos no Open Food Facts
  Future<List<FoodSearchResult>> searchFood(String query) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/cgi/search.pl',
        queryParameters: {
          'search_terms': query,
          'json': '1',
          'page_size': '20',
          'search_simple': '1',
          'action': 'process',
        },
        options: Options(
          headers: {
            'User-Agent': 'FEEDLOG - Flutter Nutrition App - https://github.com/user/feedlog',
          },
        ),
      );

      final products = response.data['products'] as List?;
      if (products == null || products.isEmpty) {
        return [];
      }

      return products.map((product) {
        // Extrair calorias do preview
        final nutriments = product['nutriments'] as Map<String, dynamic>?;
        double? caloriesPreview;
        if (nutriments != null) {
          caloriesPreview = _parseNumeric(nutriments['energy-kcal_100g']);
          // Converter kJ para kcal se necessario
          if (caloriesPreview == 0) {
            final kj = _parseNumeric(nutriments['energy_100g']);
            if (kj > 0) {
              caloriesPreview = kj / 4.184;
            }
          }
        }

        return FoodSearchResult(
          id: 'off:${product['code'] ?? product['_id']}',
          name: product['product_name'] ??
                product['product_name_en'] ??
                product['generic_name'] ??
                'Unknown',
          brandName: product['brands'],
          source: 'off',
          caloriesPreview: caloriesPreview,
        );
      }).where((result) => result.name != 'Unknown' && result.name.isNotEmpty).toList();
    } catch (e) {
      print('Open Food Facts search error: $e');
      return [];
    }
  }

  /// Obtem detalhes de um produto especifico pelo codigo de barras
  Future<FoodDetails?> getFoodDetails(String code) async {
    // Remove prefixo se existir
    final cleanCode = code.startsWith('off:') ? code.substring(4) : code;

    try {
      final response = await _dio.get(
        '$_baseUrl/api/v0/product/$cleanCode.json',
        options: Options(
          headers: {
            'User-Agent': 'FEEDLOG - Flutter Nutrition App - https://github.com/user/feedlog',
          },
        ),
      );

      if (response.data['status'] != 1) {
        return null;
      }

      final product = response.data['product'];
      final nutriments = product['nutriments'] as Map<String, dynamic>?;

      if (nutriments == null) {
        return null;
      }

      // Extrair nutrientes por 100g usando _parseNumeric para tratar String ou num
      double calories = _parseNumeric(nutriments['energy-kcal_100g']);

      // Converter kJ para kcal se necessario
      if (calories == 0) {
        final kj = _parseNumeric(nutriments['energy_100g']);
        if (kj > 0) {
          calories = kj / 4.184;
        }
      }

      final protein = _parseNumeric(nutriments['proteins_100g']);
      final carbs = _parseNumeric(nutriments['carbohydrates_100g']);
      final fat = _parseNumeric(nutriments['fat_100g']);

      // Criar servings
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

      // Adicionar serving size se disponivel
      final servingSize = product['serving_size'];
      final servingQuantity = _parseNumeric(product['serving_quantity']);

      if (servingQuantity > 0) {
        final multiplier = servingQuantity / 100;
        servings.add(ServingInfo(
          description: servingSize ?? '1 serving',
          grams: servingQuantity,
          calories: calories * multiplier,
          protein: protein * multiplier,
          carbs: carbs * multiplier,
          fat: fat * multiplier,
        ));
      }

      return FoodDetails(
        id: 'off:$cleanCode',
        name: product['product_name'] ??
              product['product_name_en'] ??
              product['generic_name'] ??
              'Unknown',
        brandName: product['brands'],
        calories: calories,
        protein: protein,
        carbs: carbs,
        fat: fat,
        servings: servings,
        source: 'off',
      );
    } catch (e) {
      print('Open Food Facts details error: $e');
      return null;
    }
  }
}

@riverpod
OpenFoodFactsService openFoodFactsService(Ref ref) {
  return OpenFoodFactsService();
}
