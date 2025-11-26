import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fatsecret_service.g.dart';

class FoodSearchResult {
  final String foodId;
  final String foodName;
  final String? brandName;
  final Map<String, dynamic> nutritionInfo;

  FoodSearchResult({
    required this.foodId,
    required this.foodName,
    this.brandName,
    required this.nutritionInfo,
  });

  factory FoodSearchResult.fromJson(Map<String, dynamic> json) {
    return FoodSearchResult(
      foodId: json['food_id'].toString(),
      foodName: json['food_name'] ?? '',
      brandName: json['brand_name'],
      nutritionInfo: json,
    );
  }
}

abstract class FatSecretService {
  Future<String> getAccessToken();
  Future<List<FoodSearchResult>> searchFood(String query);
  Future<Map<String, dynamic>> getFoodDetails(String foodId);
}

class FatSecretServiceImpl implements FatSecretService {
  final String clientId;
  final String clientSecret;
  final Dio _dio;
  
  String? _cachedToken;
  DateTime? _tokenExpiry;

  FatSecretServiceImpl({
    required this.clientId,
    required this.clientSecret,
  }) : _dio = Dio();

  @override
  Future<String> getAccessToken() async {
    // Check if we have a valid cached token
    if (_cachedToken != null && 
        _tokenExpiry != null && 
        DateTime.now().isBefore(_tokenExpiry!)) {
      return _cachedToken!;
    }

    // Get new token
    final credentials = base64Encode(utf8.encode('$clientId:$clientSecret'));
    
    try {
      final response = await _dio.post(
        'https://oauth.fatsecret.com/connect/token',
        data: 'grant_type=client_credentials&scope=basic',
        options: Options(
          headers: {
            'Authorization': 'Basic $credentials',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      _cachedToken = response.data['access_token'];
      final expiresIn = response.data['expires_in'] as int;
      _tokenExpiry = DateTime.now().add(Duration(seconds: expiresIn - 60));
      
      return _cachedToken!;
    } catch (e) {
      throw Exception('Failed to get FatSecret access token: $e');
    }
  }

  @override
  Future<List<FoodSearchResult>> searchFood(String query) async {
    final token = await getAccessToken();
    
    try {
      final response = await _dio.post(
        'https://platform.fatsecret.com/rest/server.api',
        data: {
          'method': 'foods.search',
          'search_expression': query,
          'format': 'json',
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      final foods = response.data['foods']?['food'] as List?;
      if (foods == null || foods.isEmpty) {
        return [];
      }

      return foods.map((f) => FoodSearchResult.fromJson(f)).toList();
    } catch (e) {
      throw Exception('Failed to search food: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getFoodDetails(String foodId) async {
    final token = await getAccessToken();
    
    try {
      final response = await _dio.post(
        'https://platform.fatsecret.com/rest/server.api',
        data: {
          'method': 'food.get.v2',
          'food_id': foodId,
          'format': 'json',
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      return response.data['food'] as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to get food details: $e');
    }
  }
}

@riverpod
FatSecretService fatSecretService(Ref ref) {
  // Load from environment variables (set via .env file)
  const clientId = String.fromEnvironment('FATSECRET_CLIENT_ID',
    defaultValue: 'ca5cfa5f1d0e45f19853641866772823');
  const clientSecret = String.fromEnvironment('FATSECRET_CLIENT_SECRET',
    defaultValue: 'c3b201faa34c4061bc87ac11349ce500');
  
  return FatSecretServiceImpl(
    clientId: clientId,
    clientSecret: clientSecret,
  );
}
