import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:movie/feature/movie_favorite/models/favorite_movie_models.dart';
import 'package:movie/feature/movie_detail/models/movie_detail_models.dart';
import 'package:movie/feature/movie_list/models/movie_models.dart';

class FavoriteController extends GetxController {
  final favorites = <FavoriteMovieModels>[].obs;

  late Box<FavoriteMovieModels> _box;

  @override
  void onInit() {
    super.onInit();
    _box = Hive.box<FavoriteMovieModels>('favorite');
    loadFavorites();

    // listen box biar tetap auto load
    _box.watch().listen((event) {
      loadFavorites();
    });
  }

  void loadFavorites() {
    favorites.assignAll(_box.values.toList());
  }

  void toggleFavorite(MovieModels movie) {
    if (_box.containsKey(movie.id)) {
      _box.delete(movie.id);
    } else {
      final favMovie = FavoriteMovieModels.fromMovie(movie);
      _box.put(movie.id, favMovie);
    }
  }

  void toggleFavoriteDetail(MovieDetailModels movie) {
    if (_box.containsKey(movie.id)) {
      _box.delete(movie.id);
    } else {
      final favMovie = FavoriteMovieModels.fromMovieDetail(movie);
      _box.put(movie.id, favMovie);
    }
  }

  bool isFavorite(int movieId) {
    return _box.containsKey(movieId);
  }
}
