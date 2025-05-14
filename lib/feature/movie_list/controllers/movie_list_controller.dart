import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:movie/feature/movie_list/models/movie_models.dart';
import 'package:movie/feature/movie_list/services/movie_services.dart';

class MovieController extends GetxController {
  final movies = <MovieModels>[].obs;
  final isLoading = false.obs;
  final currentPage = 1.obs;
  final hasMore = true.obs;

  final MovieService _service = MovieService();

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    try {
      final response = await _service.fetchNowPlaying(currentPage.value);
      final newMovies = response.results.where((m) => m.posterPath.isNotEmpty).toList();

      // Simpan ke Hive
      final box = Hive.box<MovieModels>('movies');
      for (var movie in newMovies) {
        box.put(movie.id, movie); // Update ke hive jika datanya ada berubah
      }

      // menghindari duplokat di tampilan
      
      final existingIds = movies.map((e) => e.id).toSet();
      final uniqueMovies = newMovies.where((m) => !existingIds.contains(m.id)).toList();

      if (uniqueMovies.isEmpty || currentPage.value >= response.totalPages) {
        hasMore.value = false;
      } else {
        movies.addAll(uniqueMovies);
        currentPage.value++;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
} 
