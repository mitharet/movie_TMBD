
import 'package:movie/core/export.dart';

class ItemMovieFavorite extends StatelessWidget {
  const ItemMovieFavorite({
    super.key,
    required this.movie,
  });

  final FavoriteMovieModels movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO ke Detail
         Get.to(()=> MovieDetailPage(movie: MovieDetailModels.fromFavorite(movie)));
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                'https://image.tmdb.org/t/p/w600_and_h900_bestv2${movie.posterPath}',
                fit: BoxFit.contain,
                width: double.infinity,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey,
                  child: const Icon(Icons.image, color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
