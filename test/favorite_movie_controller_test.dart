import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:hive/hive.dart';
import 'package:movie/feature/movie_favorite/controller/favorite_controller.dart';
import 'package:movie/feature/movie_favorite/models/favorite_movie_models.dart';
import 'package:movie/feature/movie_list/models/movie_models.dart';

import 'favorite_movie_controller_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  late MockBox<FavoriteMovieModels> mockBox;
  late FavoriteController controller;

  final movie = MovieModels(
    id: 1,
    title: 'Test Movie',
    overview: 'Overview',
    posterPath: '/poster.jpg',
    backdropPath: '/backdrop.jpg',
    releaseDate: '2024-01-01',
    voteAverage: 8.0,
    voteCount: 100,
    genreIds: [1, 2],
    adult: false,
    originalLanguage: 'en',
    originalTitle: 'Test Movie',
    popularity: 80.0,
    video: false,
  );

  final favMovie = FavoriteMovieModels.fromMovie(movie);

  setUp(() {
    mockBox = MockBox<FavoriteMovieModels>();
    controller = FavoriteController();
    controller.box = mockBox;
  });

  test('loadFavorites should load items from box', () {
    when(mockBox.values).thenReturn([favMovie]);

    controller.loadFavorites();

    expect(controller.favorites.length, 1);
    expect(controller.favorites[0].id, favMovie.id);
  });

  test('toggleFavorite should add if not exists', () {
    when(mockBox.containsKey(movie.id)).thenReturn(false);

    controller.toggleFavorite(movie);

    verify(mockBox.put(movie.id, any)).called(1);
  });

  test('toggleFavorite should delete if exists', () {
    when(mockBox.containsKey(movie.id)).thenReturn(true);

    controller.toggleFavorite(movie);

    verify(mockBox.delete(movie.id)).called(1);
  });

  test('isFavorite returns true if exists', () {
    when(mockBox.containsKey(1)).thenReturn(true);

    expect(controller.isFavorite(1), true);
  });

  test('isFavorite returns false if not exists', () {
    when(mockBox.containsKey(1)).thenReturn(false);

    expect(controller.isFavorite(1), false);
  });
}
