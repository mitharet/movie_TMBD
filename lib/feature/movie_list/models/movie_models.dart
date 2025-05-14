import 'package:hive/hive.dart';
part 'movie_models.g.dart';

@HiveType(typeId: 0)
class MovieModels extends HiveObject {
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

  MovieModels({
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

  factory MovieModels.fromJson(Map<String, dynamic> json) => MovieModels(
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
} 
