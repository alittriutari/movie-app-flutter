class ApiUrl {
  static const API_KEY = 'api_key=9c93c65e03d4ec78611e0ddd9fb55db3';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  //TV SERIES
  static const String tvSeriesOnAir = '$BASE_URL/tv/on_the_air?$API_KEY';

  static const String tvSeriesPopular = '$BASE_URL/tv/popular?$API_KEY';

  static String tvSeriesDetail(int id) => '$BASE_URL/tv/$id?$API_KEY';

  static String tvSeriesRecommendation(int id) =>
      '$BASE_URL/tv/$id/recommendations?$API_KEY';
}
