import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie/feature/movie_list/models/movie_models.dart';
import 'package:path_provider/path_provider.dart';


Future<void> initHive() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDir.path);

  // Movie Adapter
  Hive.registerAdapter(MovieModelsAdapter());

  // Simpan movie
  await Hive.openBox<MovieModels>('movies');
}
