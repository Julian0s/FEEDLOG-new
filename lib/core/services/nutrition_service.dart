import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'usda_service.dart';
import 'open_food_facts_service.dart';

part 'nutrition_service.g.dart';

/// Resultado de busca de alimento
class FoodSearchResult {
  final String id;
  final String name;
  final String? brandName;
  final String source; // 'usda' ou 'off' (open food facts)
  final double? caloriesPreview; // Preview de calorias por 100g

  FoodSearchResult({
    required this.id,
    required this.name,
    this.brandName,
    required this.source,
    this.caloriesPreview,
  });
}

/// Informacao de porcao
class ServingInfo {
  final String description;
  final double grams;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;

  ServingInfo({
    required this.description,
    required this.grams,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });
}

/// Detalhes completos do alimento
class FoodDetails {
  final String id;
  final String name;
  final String? brandName;
  final double calories; // por 100g
  final double protein; // por 100g
  final double carbs; // por 100g
  final double fat; // por 100g
  final List<ServingInfo> servings;
  final String source;

  FoodDetails({
    required this.id,
    required this.name,
    this.brandName,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.servings,
    required this.source,
  });
}

/// Interface abstrata para servico de nutricao
abstract class NutritionService {
  Future<List<FoodSearchResult>> searchFood(String query);
  Future<FoodDetails?> getFoodDetails(String foodId);
}

/// Servico hibrido que combina USDA e Open Food Facts
/// Estrategia: USDA primeiro (dados mais precisos), Open Food Facts como fallback
class HybridNutritionService implements NutritionService {
  final UsdaService _usdaService;
  final OpenFoodFactsService _offService;

  HybridNutritionService({
    required UsdaService usdaService,
    required OpenFoodFactsService offService,
  })  : _usdaService = usdaService,
        _offService = offService;

  @override
  Future<List<FoodSearchResult>> searchFood(String query) async {
    print('Searching for: "$query"');

    // 1. Tentar USDA primeiro (dados mais precisos)
    try {
      final usdaResults = await _usdaService.searchFood(query);
      if (usdaResults.isNotEmpty) {
        print('USDA: Found ${usdaResults.length} results');
        return usdaResults;
      }
    } catch (e) {
      print('USDA search error: $e');
    }

    // 2. Fallback para Open Food Facts
    try {
      final offResults = await _offService.searchFood(query);
      if (offResults.isNotEmpty) {
        print('Open Food Facts: Found ${offResults.length} results');
        return offResults;
      }
    } catch (e) {
      print('Open Food Facts search error: $e');
    }

    print('No results found for "$query"');
    return [];
  }

  @override
  Future<FoodDetails?> getFoodDetails(String foodId) async {
    // Identificar fonte pelo prefixo do ID
    if (foodId.startsWith('usda:')) {
      return await _usdaService.getFoodDetails(foodId.substring(5));
    } else if (foodId.startsWith('off:')) {
      return await _offService.getFoodDetails(foodId.substring(4));
    }

    // Se nao tiver prefixo, tentar ambos
    try {
      final usdaDetails = await _usdaService.getFoodDetails(foodId);
      if (usdaDetails != null) return usdaDetails;
    } catch (e) {
      print('USDA details error: $e');
    }

    try {
      return await _offService.getFoodDetails(foodId);
    } catch (e) {
      print('Open Food Facts details error: $e');
    }

    return null;
  }
}

@riverpod
NutritionService nutritionService(Ref ref) {
  final usdaService = ref.watch(usdaServiceProvider);
  final offService = ref.watch(openFoodFactsServiceProvider);

  return HybridNutritionService(
    usdaService: usdaService,
    offService: offService,
  );
}
