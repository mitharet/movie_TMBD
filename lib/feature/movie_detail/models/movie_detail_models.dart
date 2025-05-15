import 'package:movie/feature/movie_favorite/models/favorite_movie_models.dart';
import 'package:movie/feature/movie_list/models/movie_models.dart';

class MovieDetailModels {
  final int id;

  final String title;

  final String overview;

  final String posterPath;

  final String backdropPath;

  final String releaseDate;

  final double voteAverage;

  final int voteCount;

  final List<int> genreIds;

  final bool adult;

  final String originalLanguage;

  final String originalTitle;

  final double popularity;

  final bool video;

  MovieDetailModels({
    required this.id,
    required this.title,
    required this.overview,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.posterPath,
    required this.genreIds,
    required this.adult,
    required this.originalLanguage,
    required this.originalTitle,
    required this.popularity,
    required this.video,
  });

  factory MovieDetailModels.fromMovie(MovieModels movie) {
    return MovieDetailModels(
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      backdropPath: movie.backdropPath,
      releaseDate: movie.releaseDate,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
      posterPath: movie.posterPath,
      genreIds: movie.genreIds,
      adult: movie.adult,
      originalLanguage: movie.originalLanguage,
      originalTitle: movie.originalTitle,
      popularity: movie.popularity,
      video: movie.video,
    );
  }

  factory MovieDetailModels.fromFavorite(FavoriteMovieModels favorite) {
    return MovieDetailModels(
      id: favorite.id,
      title: favorite.title,
      overview: favorite.overview,
      backdropPath: favorite.backdropPath,
      releaseDate: favorite.releaseDate,
      voteAverage: favorite.voteAverage,
      voteCount: favorite.voteCount,
      posterPath: favorite.posterPath,
      genreIds: favorite.genreIds,
      adult: favorite.adult,
      originalLanguage: favorite.originalLanguage,
      originalTitle: favorite.originalTitle,
      popularity: favorite.popularity,
      video: favorite.video,
    );
  }
}
