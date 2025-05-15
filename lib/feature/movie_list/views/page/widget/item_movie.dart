

import 'package:movie/core/export.dart';

class ItemMovie extends StatelessWidget {
  const ItemMovie({
    super.key,
    required this.movie,
    required this.favController,
  });

  final MovieModels movie;
  final FavoriteController favController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                  Radius.circular(8)),
              child: Image.network(
                'https://image.tmdb.org/t/p/w600_and_h900_bestv2${movie.posterPath}',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey,
                  child: const Icon(Icons.image,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
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
                Obx(() {
                  final isFav = favController.favorites
                      .any((fav) => fav.id == movie.id);
                  return Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        isFav
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isFav
                            ? Colors.pink
                            : Colors.grey,
                      ),
                      onPressed: () => favController
                          .toggleFavorite(movie),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
