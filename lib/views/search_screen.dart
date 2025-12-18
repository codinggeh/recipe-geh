import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipe_geh/viewmodels/meal_viewmodel.dart';
import 'package:recipe_geh/views/meal_detail_screen.dart';
import 'package:recipe_geh/views/widgets/meal_card.dart';
import 'package:recipe_geh/views/widgets/shimmer_loading.dart';

class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final debounceTimer = useRef<Timer?>(null);
    final searchResults = ref.watch(searchResultsProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;

    void onSearchChanged(String query) {
      debounceTimer.value?.cancel();
      debounceTimer.value = Timer(const Duration(milliseconds: 500), () {
        ref.read(searchQueryProvider.notifier).state = query;
      });
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: searchController,
            onChanged: onSearchChanged,
            style: TextStyle(color: textColor),
            cursorColor: theme.colorScheme.primary,
            decoration: InputDecoration(
              hintText: 'search.hint'.tr(),
              hintStyle: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[600]),
              prefixIcon: Icon(Icons.search, color: isDark ? Colors.grey[400] : Colors.grey[600]),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                      onPressed: () {
                        searchController.clear();
                        ref.read(searchQueryProvider.notifier).state = '';
                      },
                    )
                  : null,
              filled: true,
              fillColor: isDark ? Colors.grey[900] : Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 2,
                ),
              ),
            ),
          ),
        ),

        Expanded(
          child: searchResults.when(
            data: (meals) {
              if (meals.isEmpty) {
                final query = ref.watch(searchQueryProvider);
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        query.isEmpty ? Icons.search : Icons.restaurant_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        query.isEmpty
                            ? 'search.start'.tr()
                            : 'search.no_results'.tr(),
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ],
                  ),
                );
              }

              return GridView.builder(
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
                ),
              );
            },
            loading: () => const ShimmerLoading(),
            error: (e, _) => Center(child: Text('Error: $e')),
          ),
        ),
      ],
    );
  }
}
