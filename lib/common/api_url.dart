class ApiUrl {
  static const API_KEY = 'api_key=9c93c65e03d4ec78611e0ddd9fb55db3';
  static const BASE_URL = 'https://api.themoviedb.org/3';
  static const NETWORK = 'with_networks=213';

  //TV SERIES
  static const String tvSeriesOnAir = '$BASE_URL/tv/on_the_air?$API_KEY&$NETWORK';

  static const String tvSeriesPopular = '$BASE_URL/tv/popular?$API_KEY&$NETWORK';

  static String tvSeriesDetail(int id) => '$BASE_URL/tv/$id?$API_KEY';

  static String tvSeriesRecommendation(int id) => '$BASE_URL/tv/$id/recommendations?$API_KEY&$NETWORK';

  static String searchTvSeries(String query) => '$BASE_URL/search/tv?$API_KEY&query=$query';

  static String tvSeriesSeason(int id, int seasonNumber) => '$BASE_URL/tv/$id/season/$seasonNumber?$API_KEY&$NETWORK';
}
