import 'package:movie/core/export.dart';

class MoviesPage extends StatelessWidget {
  MoviesPage({super.key});
  final MovieController controller = Get.put(MovieController());
  final FavoriteController favController = Get.put(FavoriteController());

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
              child: Column(
                children: [
                  TextField(
                    controller: controller.searchController,
                    onChanged: controller.searchMovie,
                    decoration: InputDecoration(
                      hintText: 'Search movies...',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.purple,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.purple.shade400),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final movie = controller.movies[index];
                        return GestureDetector(
                          onTap: () {
                            // TODO ke Detail
                            Get.to(() => MovieDetailPage(
                                movie: MovieDetailModels.fromMovie(movie)));
                          },
                          child: ItemMovie(movie: movie, favController: favController),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

