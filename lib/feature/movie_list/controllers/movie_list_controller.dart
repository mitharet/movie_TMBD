import 'package:get/get.dart';
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
      if (newMovies.isEmpty) {
        hasMore.value = false;
      } else {
        movies.addAll(newMovies);
        currentPage.value++;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}