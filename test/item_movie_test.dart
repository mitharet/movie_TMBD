import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:movie/feature/movie_favorite/controller/favorite_controller.dart';
import 'package:movie/feature/movie_favorite/models/favorite_movie_models.dart';
import 'package:movie/feature/movie_list/models/movie_models.dart';
import 'package:movie/feature/movie_list/views/page/widget/item_movie.dart';

import 'item_movie_test.mocks.dart'; // <- hasil generate build_runner

@GenerateMocks([FavoriteController])
void main() {
  late MockFavoriteController mockController;

  final testMovie = MovieModels(
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

  setUp(() {
    mockController = MockFavoriteController();

    when(mockController.favorites).thenReturn(<FavoriteMovieModels>[].obs);

    when(mockController.toggleFavorite(any)).thenReturn(null);
  });

  testWidgets('tap favorite icon calls toggleFavorite', (tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: ItemMovie(
            movie: testMovie,
            favController: mockController,
          ),
        ),
      ),
    );

    // Verifikasi icon awal adalah belum difavoritkan
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    // Tap icon
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pumpAndSettle();

    // Verifikasi bahwa toggleFavorite dipanggil
    verify(mockController.toggleFavorite(testMovie)).called(1);
  });
}
