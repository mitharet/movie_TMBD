import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie/feature/movie_favorite/models/favorite_movie_models.dart';
import 'package:movie/feature/movie_list/models/movie_models.dart';
import 'package:path_provider/path_provider.dart';


Future<void> initHive() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDir.path);

  // Movie Adapter
  Hive.registerAdapter(MovieModelsAdapter());
  // Favorite Movie Adapter
  Hive.registerAdapter(FavoriteMovieModelsAdapter());

  // Simpan movie list 
  await Hive.openBox<MovieModels>('movies');
  // Simpan favorite movie
  await Hive.openBox<FavoriteMovieModels>('favorite');
}
