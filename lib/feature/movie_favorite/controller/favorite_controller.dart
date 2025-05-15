import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:movie/feature/movie_favorite/models/favorite_movie_models.dart';
import 'package:movie/feature/movie_detail/models/movie_detail_models.dart';
import 'package:movie/feature/movie_list/models/movie_models.dart';

class FavoriteController extends GetxController {
  final favorites = <FavoriteMovieModels>[].obs;

  late Box<FavoriteMovieModels> box;

  @override
  void onInit() {
    super.onInit();
    box = Hive.box<FavoriteMovieModels>('favorite');
    loadFavorites();

    // listen box biar tetap auto load
    box.watch().listen((event) {
      loadFavorites();
    });
  }

  void loadFavorites() {
    favorites.assignAll(box.values.toList());
  }

  void toggleFavorite(MovieModels movie) {
    if (box.containsKey(movie.id)) {
      box.delete(movie.id);
    } else {
      final favMovie = FavoriteMovieModels.fromMovie(movie);
      box.put(movie.id, favMovie);
    }
  }

  void toggleFavoriteDetail(MovieDetailModels movie) {
    if (box.containsKey(movie.id)) {
      box.delete(movie.id);
    } else {
      final favMovie = FavoriteMovieModels.fromMovieDetail(movie);
      box.put(movie.id, favMovie);
    }
  }

  bool isFavorite(int movieId) {
    return box.containsKey(movieId);
  }
}
