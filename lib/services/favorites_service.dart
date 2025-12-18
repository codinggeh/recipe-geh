import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipe_geh/models/meal.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorite_meals';

  Future<List<Meal>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_favoritesKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Meal.fromJson(json)).toList();
  }

  Future<void> addFavorite(Meal meal) async {
    final favorites = await getFavorites();
    if (!favorites.any((m) => m.id == meal.id)) {
      favorites.add(meal);
      await _saveFavorites(favorites);
    }
  }

  Future<void> removeFavorite(String mealId) async {
    final favorites = await getFavorites();
    favorites.removeWhere((m) => m.id == mealId);
    await _saveFavorites(favorites);
  }

  Future<bool> isFavorite(String mealId) async {
    final favorites = await getFavorites();
    return favorites.any((m) => m.id == mealId);
  }

  Future<bool> toggleFavorite(Meal meal) async {
    final isFav = await isFavorite(meal.id);
    if (isFav) {
      await removeFavorite(meal.id);
      return false;
    } else {
      await addFavorite(meal);
      return true;
    }
  }

  Future<void> _saveFavorites(List<Meal> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = favorites.map((m) => m.toJson()).toList();
    await prefs.setString(_favoritesKey, json.encode(jsonList));
  }
}
