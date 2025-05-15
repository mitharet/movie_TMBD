import 'package:hive/hive.dart';
import 'package:movie/feature/movie_detail/models/movie_detail_models.dart';
import 'package:movie/feature/movie_list/models/movie_models.dart';
part 'favorite_movie_models.g.dart';

@HiveType(typeId: 1)
class FavoriteMovieModels extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String overview;

  @HiveField(3)
  final String posterPath;

  @HiveField(4)
  final String backdropPath;

  @HiveField(5)
  final String releaseDate;

  @HiveField(6)
  final double voteAverage;

  @HiveField(7)
  final int voteCount;

  @HiveField(8)
  final List<int> genreIds;

  @HiveField(9)
  final bool adult;

  @HiveField(10)
  final String originalLanguage;

  @HiveField(11)
  final String originalTitle;

  @HiveField(12)
  final double popularity;

  @HiveField(13)
  final bool video;

  FavoriteMovieModels({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.genreIds,
    required this.adult,
    required this.originalLanguage,
    required this.originalTitle,
    required this.popularity,
    required this.video,
  });

  factory FavoriteMovieModels.fromJson(Map<String, dynamic> json) =>
      FavoriteMovieModels(
        id: json['id'],
        title: json['title'],
        overview: json['overview'],
        posterPath: json['poster_path'] ?? '',
        backdropPath: json['backdrop_path'] ?? '',
        releaseDate: json['release_date'] ?? '',
        voteAverage: (json['vote_average'] as num).toDouble(),
        voteCount: json['vote_count'],
        genreIds: List<int>.from(json['genre_ids']),
        adult: json['adult'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        popularity: (json['popularity'] as num).toDouble(),
        video: json['video'],
      );

  factory FavoriteMovieModels.fromMovie(MovieModels movie) {
    return FavoriteMovieModels(
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      posterPath: movie.posterPath,
      backdropPath: movie.backdropPath,
      releaseDate: movie.releaseDate,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
      genreIds: List<int>.from(movie.genreIds),
      adult: movie.adult,
      originalLanguage: movie.originalLanguage,
      originalTitle: movie.originalTitle,
      popularity: movie.popularity,
      video: movie.video,
    );
  }

  factory FavoriteMovieModels.fromMovieDetail(MovieDetailModels movie) {
    return FavoriteMovieModels(
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      posterPath: movie.posterPath,
      backdropPath: movie.backdropPath,
      releaseDate: movie.releaseDate,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
      genreIds: List<int>.from(movie.genreIds),
      adult: movie.adult,
      originalLanguage: movie.originalLanguage,
      originalTitle: movie.originalTitle,
      popularity: movie.popularity,
      video: movie.video,
    );
  }
}
