import 'package:movie/feature/movie_list/models/movie_models.dart';

class MovieResponse {
  final int page;
  final List<MovieModels> results;
  final int totalPages;
  final int totalResults;

  MovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      page: json['page'],
      results: List<MovieModels>.from(json['results'].map((x) => MovieModels.fromJson(x))),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}
