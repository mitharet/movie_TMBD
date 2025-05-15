import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert';

import 'package:movie/core/services/movie_services.dart';
import 'package:movie/feature/movie_list/models/movie_response.dart';

import 'movie_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MovieService service;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    service = MovieService(client: mockClient);
  });

  test('returns MovieResponse if the http call completes successfully', () async {
    final fakeJson = {
      "page": 1,
      "results": [
        {
          "id": 1,
          "title": "Movie One",
          "overview": "Overview One",
          "poster_path": "/path1.jpg",
          "backdrop_path": "/backdrop1.jpg",
          "release_date": "2024-01-01",
          "vote_average": 8.0,
          "vote_count": 100,
          "genre_ids": [1, 2],
          "adult": false,
          "original_language": "en",
          "original_title": "Original One",
          "popularity": 100.0,
          "video": false
        }
      ],
      "total_pages": 1,
      "total_results": 1
    };

    when(mockClient.get(any)).thenAnswer(
      (_) async => http.Response(json.encode(fakeJson), 200),
    );

    final result = await service.fetchNowPlaying(1);

    expect(result, isA<MovieResponse>());
    expect(result.results.length, 1);
    expect(result.results[0].title, 'Movie One');
  });

  test('throws exception if the http call completes with an error', () {
    when(mockClient.get(any)).thenAnswer(
      (_) async => http.Response('Not Found', 404),
    );

    expect(service.fetchNowPlaying(1), throwsException);
  });
}
