import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_geh/models/meal.dart';
import 'package:recipe_geh/services/favorites_service.dart';

final favoritesServiceProvider = Provider((ref) => FavoritesService());

final favoritesProvider =
    AsyncNotifierProvider<FavoritesNotifier, List<Meal>>(
  FavoritesNotifier.new,
);

class FavoritesNotifier extends AsyncNotifier<List<Meal>> {
  @override
  Future<List<Meal>> build() async {
    final service = ref.read(favoritesServiceProvider);
    return service.getFavorites();
  }

  Future<void> toggleFavorite(Meal meal) async {
    final service = ref.read(favoritesServiceProvider);
    await service.toggleFavorite(meal);
    ref.invalidateSelf();
  }

  Future<void> removeFavorite(String mealId) async {
    final service = ref.read(favoritesServiceProvider);
    await service.removeFavorite(mealId);
    ref.invalidateSelf();
  }
}

final isFavoriteProvider = FutureProvider.family<bool, String>((ref, mealId) async {
  final service = ref.read(favoritesServiceProvider);
  return service.isFavorite(mealId);
});
