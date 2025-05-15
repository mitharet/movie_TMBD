

import 'package:movie/core/export.dart';
import 'package:movie/feature/movie_favorite/view/widget/item_movie_favorite.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});

  final FavoriteController controller = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = MediaQuery.of(context).size.width > 600 ? 4 : 2;

    return Scaffold(
         appBar: AppBar(
        title: const Text('My Favorite Movie', style: TextStyle(fontSize: 24)),
        centerTitle: false,
      ),
      body: Obx(() {
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.65,
          ),
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            final movie = controller.favorites[index];
            return ItemMovieFavorite(movie: movie);
          },
        );
      }),
    );
  }
}

