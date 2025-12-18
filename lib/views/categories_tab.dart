import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_geh/viewmodels/meal_viewmodel.dart';
import 'package:recipe_geh/views/meal_detail_screen.dart';
import 'package:recipe_geh/views/widgets/meal_card.dart';
import 'package:recipe_geh/views/widgets/shimmer_loading.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesTab extends ConsumerWidget {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return categoriesAsync.when(
      data: (categories) {
        return Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category.name;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(category.name),
                      selected: isSelected,
                      onSelected: (_) {
                        ref.read(selectedCategoryProvider.notifier).state = category.name;
                      },
                      selectedColor: theme.colorScheme.primary,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : null,
                        fontWeight: isSelected ? FontWeight.w600 : null,
                      ),
                    ),
                  ).animate().fadeIn(delay: (index * 50).ms);
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: selectedCategory == null
                  ? _buildCategoryGrid(context, categories, ref, isDark)
                  : _buildMealsGrid(context, ref, selectedCategory),
            ),
          ],
        );
      },
      loading: () => const ShimmerLoading(),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildCategoryGrid(BuildContext context, List categories, WidgetRef ref, bool isDark) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            ref.read(selectedCategoryProvider.notifier).state = category.name;
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (category.thumbnail != null)
                  CachedNetworkImage(
                    imageUrl: category.thumbnail!,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Shimmer.fromColors(
                      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
                      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[200]!,
                      child: Container(color: Colors.grey),
                    ),
                  ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(179),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Text(
                    category.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(delay: (index * 50).ms).scale(begin: const Offset(0.95, 0.95));
      },
    );
  }

  Widget _buildMealsGrid(BuildContext context, WidgetRef ref, String category) {
    final mealsAsync = ref.watch(mealsByCategoryProvider(category));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  ref.read(selectedCategoryProvider.notifier).state = null;
                },
              ),
              Text(
                category,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        Expanded(
          child: mealsAsync.when(
            data: (meals) => GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: meals.length,
              itemBuilder: (context, index) => MealCard(
                meal: meals[index],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MealDetailScreen(mealId: meals[index].id),
                  ),
                ),
              ).animate().fadeIn(delay: (index * 30).ms),
            ),
            loading: () => const ShimmerLoading(),
            error: (e, _) => Center(child: Text('Error: $e')),
          ),
        ),
      ],
    );
  }
}
