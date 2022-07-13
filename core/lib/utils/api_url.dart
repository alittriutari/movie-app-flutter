class ApiUrl {
  static const apiKey = 'api_key=9c93c65e03d4ec78611e0ddd9fb55db3';
  static const baseUrl = 'https://api.themoviedb.org/3';
  static const apiNetwork = 'with_networks=213';

  //MOVIE
  static const String moviePopular = '$baseUrl/movie/popular?$apiKey';
  static const String movieTopRated = '$baseUrl/movie/top_rated?$apiKey';
  static const String movieNowPlaying = '$baseUrl/movie/now_playing?$apiKey';
  static String movieDetail(int id) => '$baseUrl/movie/$id?$apiKey';
  static String movieRecommencation(int id) => '$baseUrl/movie/$id/recommendations?$apiKey';
  static String searchMovies(String query) => '$baseUrl/search/movie?$apiKey&query=$query';

  //TV SERIES
  static const String tvSeriesOnAir = '$baseUrl/tv/on_the_air?$apiKey&$apiNetwork';
  static const String tvSeriesPopular = '$baseUrl/tv/popular?$apiKey&$apiNetwork';
  static const String tvSeriesTopRated = '$baseUrl/tv/top_rated?$apiKey&$apiNetwork';
  static String tvSeriesDetail(int id) => '$baseUrl/tv/$id?$apiKey';
  static String tvSeriesRecommendation(int id) => '$baseUrl/tv/$id/recommendations?$apiKey&$apiNetwork';
  static String searchTvSeries(String query) => '$baseUrl/search/tv?$apiKey&query=$query';
  static String tvSeriesSeason(int id, int seasonNumber) => '$baseUrl/tv/$id/season/$seasonNumber?$apiKey&$apiNetwork';
}
