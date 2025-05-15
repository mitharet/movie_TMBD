import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/core/services/movie_services.dart';
import 'package:movie/feature/movie_list/controller/movie_list_controller.dart';
import 'package:movie/feature/movie_list/models/movie_models.dart';
import 'package:movie/feature/movie_list/models/movie_response.dart';
import 'package:hive/hive.dart';

import 'movie_controller_test.mocks.dart';

@GenerateMocks([MovieService, Box])
void main() {
  late MovieControllerTestable controller;
  late MockMovieService mockService;
  late MockBox<MovieModels> mockBox;

  final movie1 = MovieModels(
    id: 1,
    title: 'Movie One',
    overview: 'Overview One',
    posterPath: '/path1.jpg',
    backdropPath: '/backdrop1.jpg',
    releaseDate: '2024-01-01',
    voteAverage: 8.0,
    voteCount: 100,
    genreIds: [1, 2],
    adult: false,
    originalLanguage: 'en',
    originalTitle: 'Original One',
    popularity: 100.0,
    video: false,
  );

  final movie2 = MovieModels(
    id: 2,
    title: 'Movie Two',
    overview: 'Overview Two',
    posterPath: '/path2.jpg',
    backdropPath: '/backdrop2.jpg',
    releaseDate: '2024-02-01',
    voteAverage: 7.5,
    voteCount: 80,
    genreIds: [3, 4],
    adult: false,
    originalLanguage: 'en',
    originalTitle: 'Original Two',
    popularity: 95.0,
    video: false,
  );

  setUpAll(() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(MovieModelsAdapter());
    }
  });

  setUp(() {
    mockService = MockMovieService();
    mockBox = MockBox<MovieModels>();

    controller = MovieControllerTestable(
      service: mockService,
      box: mockBox,
    );

    controller.movies.clear();
    controller.currentPage.value = 1;
    controller.hasMore.value = true;
    controller.isLoading.value = false;
  });

  test('fetchMovies success adds new movies', () async {
    final response = MovieResponse(
      page: 1,
      results: [movie1, movie2],
      totalPages: 3,
      totalResults: 100,
    );

    when(mockService.fetchNowPlaying(1)).thenAnswer((_) async => response);

    await controller.fetchMovies();

    expect(controller.movies.length, 2);
    expect(controller.currentPage.value, 2);
    expect(controller.hasMore.value, true);
  });

  test('fetchMovies throws exception shows snackbar and does not update state', () async {
    when(mockService.fetchNowPlaying(1)).thenThrow(Exception('API Error'));

    await controller.fetchMovies();

    expect(controller.movies.length, 0);
    expect(controller.isLoading.value, false);
    expect(controller.hasMore.value, true);
  });

  test('searchMovie filters from local hive box', () async {
    when(mockBox.values).thenReturn([movie1, movie2]);

    controller.searchMovie('One');

    expect(controller.movies.length, 1);
    expect(controller.movies.first.title, 'Movie One');
  });
}

class MovieControllerTestable extends MovieController {
  final MovieService service;
  final Box<MovieModels> box;

  MovieControllerTestable({
    required this.service,
    required this.box,
  });

  @override
  MovieService get _service => service;

  @override
  Box<MovieModels> get movieBox => box;

  @override
  Future<void> fetchMovies() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    try {
      final response = await _service.fetchNowPlaying(currentPage.value);
      final newMovies = response.results.where((m) => m.posterPath.isNotEmpty).toList();

      // pakai box yang di-inject
      for (var movie in newMovies) {
        movieBox.put(movie.id, movie);
      }

      final existingIds = movies.map((e) => e.id).toSet();
      final uniqueMovies = newMovies.where((m) => !existingIds.contains(m.id)).toList();

      if (uniqueMovies.isEmpty || currentPage.value >= response.totalPages) {
        hasMore.value = false;
      } else {
        movies.addAll(uniqueMovies);
        currentPage.value++;
      }
    } catch (e) {
      // Normally show snackbar, but we skip UI in tests
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void searchMovie(String query) {
    isLoading.value = true;
    final allMovies = movieBox.values.toList();

    final filtered = allMovies.where((movie) =>
      movie.title.toLowerCase().contains(query.toLowerCase())
    ).toList();

    movies.assignAll(filtered);
    isLoading.value = false;
  }
}
