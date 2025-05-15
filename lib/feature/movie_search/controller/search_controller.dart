import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:movie/feature/movie_list/models/movie_models.dart';

class SearchMovieController extends GetxController {
  final searchController = TextEditingController();
  final movies = <MovieModels>[].obs;
  final isLoading = false.obs;

  void searchOffline(String query) async {
    isLoading.value = true;
    final box = Hive.box<MovieModels>('movies');
    final allMovies = box.values.toList();

    final filtered = allMovies.where((movie) =>
      movie.title.toLowerCase().contains(query.toLowerCase())
    ).toList();

    movies.assignAll(filtered);
    isLoading.value = false;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
