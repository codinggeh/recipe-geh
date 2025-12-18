import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:recipe_geh/models/meal.dart';
import 'package:recipe_geh/viewmodels/favorites_viewmodel.dart';
import 'package:recipe_geh/viewmodels/meal_viewmodel.dart';
import 'package:shimmer/shimmer.dart';

class MealDetailScreen extends ConsumerWidget {
  final String mealId;

  const MealDetailScreen({super.key, required this.mealId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealAsync = ref.watch(mealDetailProvider(mealId));
    final isFavAsync = ref.watch(isFavoriteProvider(mealId));

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;

    return Scaffold(
      body: mealAsync.when(
        data: (meal) => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              leading: Padding(
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withAlpha(128),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withAlpha(128),
                    child: IconButton(
                      icon: const Icon(Icons.share, color: Colors.white),
                      onPressed: () {
                        Share.share('Check out this recipe: ${meal.name}\n${meal.source ?? ''}');
                      },
                    ),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: meal.thumbnail != null
                    ? CachedNetworkImage(
                        imageUrl: meal.thumbnail!,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => _buildShimmer(isDark),
                      )
                    : _buildPlaceholder(isDark),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ).animate().fadeIn().slideX(begin: -0.1),

                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 8,
                      children: [
                        if (meal.category != null)
                          Chip(
                            avatar: const Icon(Icons.category, size: 16),
                            label: Text(meal.category!),
                          ),
                        if (meal.area != null)
                          Chip(
                            avatar: const Icon(Icons.location_on, size: 16),
                            label: Text(meal.area!),
                          ),
                      ],
                    ).animate().fadeIn(delay: 100.ms),

                    if (meal.youtube != null) ...[
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: () => launchUrl(Uri.parse(meal.youtube!)),
                        icon: const Icon(Icons.play_circle_outline),
                        label: Text('meal.watch_video'.tr()),
                      ),
                    ],

                    const SizedBox(height: 24),

                    Text(
                      'meal.ingredients'.tr(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...meal.ingredients.asMap().entries.map((entry) {
                      final index = entry.key;
                      final ingredient = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                '${ingredient.value} ${ingredient.key}',
                                style: TextStyle(color: textColor),
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: (index * 30).ms).slideX(begin: 0.1);
                    }),

                    const SizedBox(height: 24),

                    Text(
                      'meal.instructions'.tr(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      meal.instructions ?? 'meal.no_instructions'.tr(),
                      style: TextStyle(
                        color: isDark ? Colors.grey[300] : Colors.grey[700],
                        height: 1.6,
                      ),
                    ).animate().fadeIn(delay: 200.ms),

                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),

      floatingActionButton: mealAsync.whenOrNull(
        data: (meal) => FloatingActionButton(
          onPressed: () {
            ref.read(favoritesProvider.notifier).toggleFavorite(meal);
            ref.invalidate(isFavoriteProvider(mealId));
          },
          child: isFavAsync.when(
            data: (isFav) => Icon(
              isFav ? Icons.favorite : Icons.favorite_outline,
              color: isFav ? Colors.red : Colors.white,
            ),
            loading: () => const Icon(Icons.favorite_outline),
            error: (_, __) => const Icon(Icons.favorite_outline),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmer(bool isDark) {
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[200]!,
      child: Container(color: Colors.grey),
    );
  }

  Widget _buildPlaceholder(bool isDark) {
    return Container(
      color: isDark ? Colors.grey[800] : Colors.grey[300],
      child: const Icon(Icons.restaurant, size: 64, color: Colors.grey),
    );
  }
}
