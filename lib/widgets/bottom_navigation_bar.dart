import 'package:flutter/material.dart';
import 'package:movieapp/constants.dart';
import 'package:movieapp/providers/bottombar_navigation_provider.dart';
import 'package:movieapp/pages/home_page.dart';
import 'package:movieapp/pages/bookmarks_page.dart';
import 'package:movieapp/pages/search_page.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    var navigationProvider = Provider.of<NavigationProvider>(context);

    return BottomNavigationBar(
      backgroundColor: blackColor,
      selectedItemColor: yellowColor,
      unselectedItemColor: whiteColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 28,
      currentIndex: navigationProvider.currentIndex,
      onTap: (index) {
        navigationProvider.updateIndex(index);
        switch (index) {
          case 0:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
            break;
          case 1:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ),
            );
            break;
          case 2:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const SavedPage(),
              ),
            );
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_outline),
          label: 'Saved',
        ),
      ],
    );
  }

  Widget getPage(BuildContext context) {
    var navigationProvider = Provider.of<NavigationProvider>(context);
    switch (navigationProvider.currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const SearchPage();
      case 2:
        return const SavedPage();
      default:
        return const HomePage();
    }
  }
}
