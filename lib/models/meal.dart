import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal.freezed.dart';
part 'meal.g.dart';

@freezed
class Meal with _$Meal {
  const factory Meal({
    @JsonKey(name: 'idMeal') required String id,
    @JsonKey(name: 'strMeal') required String name,
    @JsonKey(name: 'strCategory') String? category,
    @JsonKey(name: 'strArea') String? area,
    @JsonKey(name: 'strInstructions') String? instructions,
    @JsonKey(name: 'strMealThumb') String? thumbnail,
    @JsonKey(name: 'strTags') String? tags,
    @JsonKey(name: 'strYoutube') String? youtube,
    @JsonKey(name: 'strSource') String? source,
    @JsonKey(name: 'strIngredient1') String? ingredient1,
    @JsonKey(name: 'strIngredient2') String? ingredient2,
    @JsonKey(name: 'strIngredient3') String? ingredient3,
    @JsonKey(name: 'strIngredient4') String? ingredient4,
    @JsonKey(name: 'strIngredient5') String? ingredient5,
    @JsonKey(name: 'strIngredient6') String? ingredient6,
    @JsonKey(name: 'strIngredient7') String? ingredient7,
    @JsonKey(name: 'strIngredient8') String? ingredient8,
    @JsonKey(name: 'strIngredient9') String? ingredient9,
    @JsonKey(name: 'strIngredient10') String? ingredient10,
    @JsonKey(name: 'strMeasure1') String? measure1,
    @JsonKey(name: 'strMeasure2') String? measure2,
    @JsonKey(name: 'strMeasure3') String? measure3,
    @JsonKey(name: 'strMeasure4') String? measure4,
    @JsonKey(name: 'strMeasure5') String? measure5,
    @JsonKey(name: 'strMeasure6') String? measure6,
    @JsonKey(name: 'strMeasure7') String? measure7,
    @JsonKey(name: 'strMeasure8') String? measure8,
    @JsonKey(name: 'strMeasure9') String? measure9,
    @JsonKey(name: 'strMeasure10') String? measure10,
  }) = _Meal;

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
}

extension MealExtension on Meal {
  List<MapEntry<String, String>> get ingredients {
    final list = <MapEntry<String, String>>[];
    final ingredientsList = [
      ingredient1, ingredient2, ingredient3, ingredient4, ingredient5,
      ingredient6, ingredient7, ingredient8, ingredient9, ingredient10,
    ];
    final measuresList = [
      measure1, measure2, measure3, measure4, measure5,
      measure6, measure7, measure8, measure9, measure10,
    ];

    for (var i = 0; i < ingredientsList.length; i++) {
      final ingredient = ingredientsList[i];
      final measure = measuresList[i];
      if (ingredient != null && ingredient.isNotEmpty) {
        list.add(MapEntry(ingredient, measure ?? ''));
      }
    }
    return list;
  }
}

@freezed
class Category with _$Category {
  const factory Category({
    @JsonKey(name: 'idCategory') required String id,
    @JsonKey(name: 'strCategory') required String name,
    @JsonKey(name: 'strCategoryThumb') String? thumbnail,
    @JsonKey(name: 'strCategoryDescription') String? description,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
}

@freezed
class MealResponse with _$MealResponse {
  const factory MealResponse({
    @Default([]) List<Meal> meals,
  }) = _MealResponse;

  factory MealResponse.fromJson(Map<String, dynamic> json) => _$MealResponseFromJson(json);
}

@freezed
class CategoryResponse with _$CategoryResponse {
  const factory CategoryResponse({
    @Default([]) List<Category> categories,
  }) = _CategoryResponse;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => _$CategoryResponseFromJson(json);
}
