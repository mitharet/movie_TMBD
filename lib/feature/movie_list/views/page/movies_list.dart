import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/feature/movie_list/controllers/movie_list_controller.dart';

class MoviesPage extends StatelessWidget {
  MoviesPage({super.key});
  final MovieController controller = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Showing Movie', style: TextStyle(fontSize: 24)),
        centerTitle: false,
      ),
      body: Obx(
        () {
          if (controller.isLoading.value && controller.movies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!controller.isLoading.value &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                controller.fetchMovies();
              }
              return false;
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemCount: controller.hasMore.value
                    ? controller.movies.length + 1
                    : controller.movies.length,
                itemBuilder: (context, index) {
                  if (index == controller.movies.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final movie = controller.movies[index];
                  return GestureDetector(
                    onTap: () {
                      // TODO ke Detail
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w600_and_h900_bestv2${movie.posterPath}',
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.grey,
                                child: const Icon(Icons.image,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  movie.releaseDate,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
