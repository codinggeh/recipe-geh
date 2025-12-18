import 'package:recipe_geh/core/constants/api_constants.dart';
import 'package:recipe_geh/core/utils/api_helper.dart';
import 'package:recipe_geh/models/meal.dart';

class MealService {
  final _dio = ApiHelper.dio;

  Future<Meal> getRandomMeal() async {
    final response = await _dio.get(ApiConstants.randomMeal);
    final data = response.data;
    if (data['meals'] != null && (data['meals'] as List).isNotEmpty) {
      return Meal.fromJson(data['meals'][0]);
    }
    throw Exception('No meal found');
  }

  Future<List<Meal>> searchMeals(String query) async {
    final response = await _dio.get(
      ApiConstants.searchMeal,
      queryParameters: {'s': query},
    );
    final data = response.data;
    if (data['meals'] == null) return [];
    return (data['meals'] as List).map((e) => Meal.fromJson(e)).toList();
  }

  Future<Meal> getMealById(String id) async {
    final response = await _dio.get(
      ApiConstants.mealById,
      queryParameters: {'i': id},
    );
    final data = response.data;
    if (data['meals'] != null && (data['meals'] as List).isNotEmpty) {
      return Meal.fromJson(data['meals'][0]);
    }
    throw Exception('Meal not found');
  }

  Future<List<Category>> getCategories() async {
    final response = await _dio.get(ApiConstants.categories);
    final data = CategoryResponse.fromJson(response.data);
    return data.categories;
  }

  Future<List<Meal>> getMealsByCategory(String category) async {
    final response = await _dio.get(
      ApiConstants.filterByCategory,
      queryParameters: {'c': category},
    );
    final data = response.data;
    if (data['meals'] == null) return [];
    return (data['meals'] as List).map((e) => Meal.fromJson(e)).toList();
  }
}
