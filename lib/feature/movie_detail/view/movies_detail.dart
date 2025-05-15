
import 'package:movie/core/export.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieDetailModels movie;

  MovieDetailPage({
    super.key,
    required this.movie,
  });
  final FavoriteController favController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              'https://image.tmdb.org/t/p/w600_and_h900_bestv2${movie.backdropPath}',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 400,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Release Date: ${movie.releaseDate}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber[600]),
                      const SizedBox(width: 4),
                      Text(
                        "${movie.voteAverage} (${movie.voteCount} votes)",
                        style: const TextStyle(fontSize: 14),
                      ),
                       Obx(() {
                                 final isFav = favController.favorites.any((fav) => fav.id == movie.id);
                                  return IconButton(
                                    icon: Icon(
                                      isFav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFav ? Colors.pink : Colors.grey,
                                    ),
                                    onPressed: () =>
                                        favController.toggleFavoriteDetail(movie),
                                  );
                                }),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Overview",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.overview,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
