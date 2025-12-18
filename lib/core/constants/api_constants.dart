class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';
  static const String randomMeal = '/random.php';
  static const String searchMeal = '/search.php';
  static const String mealById = '/lookup.php';
  static const String categories = '/categories.php';
  static const String filterByCategory = '/filter.php';
  static const String listAreas = '/list.php?a=list';
  static const String filterByArea = '/filter.php';

  static String imageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return '';
    return imageUrl;
  }
}
