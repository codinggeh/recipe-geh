import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_geh/models/meal.dart';
import 'package:recipe_geh/services/meal_service.dart';

final mealServiceProvider = Provider((ref) => MealService());

final randomMealProvider = FutureProvider.autoDispose<Meal>((ref) async {
  final service = ref.read(mealServiceProvider);
  return service.getRandomMeal();
});

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final service = ref.read(mealServiceProvider);
  return service.getCategories();
});

final selectedCategoryProvider = StateProvider<String?>((ref) => null);

final mealsByCategoryProvider = FutureProvider.family<List<Meal>, String>((ref, category) async {
  final service = ref.read(mealServiceProvider);
  return service.getMealsByCategory(category);
});

final mealDetailProvider = FutureProvider.family<Meal, String>((ref, id) async {
  final service = ref.read(mealServiceProvider);
  return service.getMealById(id);
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider<List<Meal>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty || query.length < 2) return [];

  final service = ref.read(mealServiceProvider);
  return service.searchMeals(query);
});
