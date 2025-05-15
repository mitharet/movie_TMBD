import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/feature/movie_list/views/pages.dart';



class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final BottomNavBarController controller = Get.put(BottomNavBarController());

  final List<Map<String, dynamic>> _tabs = [
    {"label": "Movies", "icon": Icons.movie, "route": "/movies", "page":  MoviesPage()},
    {"label": "Search", "icon": Icons.search, "route": "/search", "page":  SearchPage()},
    {"label": "Favorite", "icon": Icons.favorite, "route": "/favorite", "page": const FavoritePage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _tabs[controller.selectedIndex.value]["page"]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: _tabs.map((tab) {
              return BottomNavigationBarItem(
                icon: Icon(tab["icon"]),
                label: tab["label"],
              );
            }).toList(),
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.grey,
            onTap: controller.changeTab,
            showUnselectedLabels: true,
          )),
    );
  }
}




