import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:movie/feature/movie_list/models/movie_models.dart';
import 'package:movie/feature/movie_search/controller/search_controller.dart';

void main() {
  late SearchMovieController controller;
  late Box<MovieModels> movieBox;

  final dummyMovies = [
    MovieModels(
      id: 1,
      title: 'Avengers: Endgame',
      overview: '',
      posterPath: '',
      backdropPath: '',
      releaseDate: '2019-04-24',
      voteAverage: 8.4,
      voteCount: 10000,
      genreIds: [28, 12],
      adult: false,
      originalLanguage: 'en',
      originalTitle: 'Avengers: Endgame',
      popularity: 500.0,
      video: false,
    ),
    MovieModels(
      id: 2,
      title: 'Iron Man',
      overview: '',
      posterPath: '',
      backdropPath: '',
      releaseDate: '2008-05-02',
      voteAverage: 7.9,
      voteCount: 8500,
      genreIds: [28, 878],
      adult: false,
      originalLanguage: 'en',
      originalTitle: 'Iron Man',
      popularity: 450.0,
      video: false,
    ),
  ];

  setUp(() async {
    await setUpTestHive();

    Hive.registerAdapter(MovieModelsAdapter()); // pastikan ada adapter Hive-nya
    movieBox = await Hive.openBox<MovieModels>('movies');

    for (var movie in dummyMovies) {
      await movieBox.put(movie.id, movie);
    }

    controller = SearchMovieController();
  });

  tearDown(() async {
    await movieBox.close();
    await tearDownTestHive();
  });

  test('searchOffline finds correct movie', () async {
    controller.searchOffline('Iron');
    await Future.delayed(Duration(milliseconds: 100));

    expect(controller.movies.length, 1);
    expect(controller.movies.first.title, 'Iron Man');
  });

  test('searchOffline returns empty if not found', () async {
    controller.searchOffline('Batman');
    await Future.delayed(Duration(milliseconds: 100));

    expect(controller.movies.isEmpty, true);
  });
}
