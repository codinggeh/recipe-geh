// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MealImpl _$$MealImplFromJson(Map<String, dynamic> json) => _$MealImpl(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      category: json['strCategory'] as String?,
      area: json['strArea'] as String?,
      instructions: json['strInstructions'] as String?,
      thumbnail: json['strMealThumb'] as String?,
      tags: json['strTags'] as String?,
      youtube: json['strYoutube'] as String?,
      source: json['strSource'] as String?,
      ingredient1: json['strIngredient1'] as String?,
      ingredient2: json['strIngredient2'] as String?,
      ingredient3: json['strIngredient3'] as String?,
      ingredient4: json['strIngredient4'] as String?,
      ingredient5: json['strIngredient5'] as String?,
      ingredient6: json['strIngredient6'] as String?,
      ingredient7: json['strIngredient7'] as String?,
      ingredient8: json['strIngredient8'] as String?,
      ingredient9: json['strIngredient9'] as String?,
      ingredient10: json['strIngredient10'] as String?,
      measure1: json['strMeasure1'] as String?,
      measure2: json['strMeasure2'] as String?,
      measure3: json['strMeasure3'] as String?,
      measure4: json['strMeasure4'] as String?,
      measure5: json['strMeasure5'] as String?,
      measure6: json['strMeasure6'] as String?,
      measure7: json['strMeasure7'] as String?,
      measure8: json['strMeasure8'] as String?,
      measure9: json['strMeasure9'] as String?,
      measure10: json['strMeasure10'] as String?,
    );

Map<String, dynamic> _$$MealImplToJson(_$MealImpl instance) =>
    <String, dynamic>{
      'idMeal': instance.id,
      'strMeal': instance.name,
      'strCategory': instance.category,
      'strArea': instance.area,
      'strInstructions': instance.instructions,
      'strMealThumb': instance.thumbnail,
      'strTags': instance.tags,
      'strYoutube': instance.youtube,
      'strSource': instance.source,
      'strIngredient1': instance.ingredient1,
      'strIngredient2': instance.ingredient2,
      'strIngredient3': instance.ingredient3,
      'strIngredient4': instance.ingredient4,
      'strIngredient5': instance.ingredient5,
      'strIngredient6': instance.ingredient6,
      'strIngredient7': instance.ingredient7,
      'strIngredient8': instance.ingredient8,
      'strIngredient9': instance.ingredient9,
      'strIngredient10': instance.ingredient10,
      'strMeasure1': instance.measure1,
      'strMeasure2': instance.measure2,
      'strMeasure3': instance.measure3,
      'strMeasure4': instance.measure4,
      'strMeasure5': instance.measure5,
      'strMeasure6': instance.measure6,
      'strMeasure7': instance.measure7,
      'strMeasure8': instance.measure8,
      'strMeasure9': instance.measure9,
      'strMeasure10': instance.measure10,
    };

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
      id: json['idCategory'] as String,
      name: json['strCategory'] as String,
      thumbnail: json['strCategoryThumb'] as String?,
      description: json['strCategoryDescription'] as String?,
    );

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) =>
    <String, dynamic>{
      'idCategory': instance.id,
      'strCategory': instance.name,
      'strCategoryThumb': instance.thumbnail,
      'strCategoryDescription': instance.description,
    };

_$MealResponseImpl _$$MealResponseImplFromJson(Map<String, dynamic> json) =>
    _$MealResponseImpl(
      meals: (json['meals'] as List<dynamic>?)
              ?.map((e) => Meal.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$MealResponseImplToJson(_$MealResponseImpl instance) =>
    <String, dynamic>{
      'meals': instance.meals,
    };

_$CategoryResponseImpl _$$CategoryResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CategoryResponseImpl(
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CategoryResponseImplToJson(
        _$CategoryResponseImpl instance) =>
    <String, dynamic>{
      'categories': instance.categories,
    };
