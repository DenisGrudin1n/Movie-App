import 'package:flutter/material.dart';
import 'package:movieapp/constants.dart';
import 'package:movieapp/providers/bottombar_navigation_provider.dart';
import 'package:movieapp/screens/home_page.dart';
import 'package:movieapp/widgets/bottom_navigation_bar.dart';
import 'package:movieapp/widgets/build_rating_stars.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 40, 20, 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      var navigationProvider = Provider.of<NavigationProvider>(
                          context,
                          listen: false);
                      navigationProvider.updateIndex(0);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 35,
                      color: yellowColor,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    "Search",
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 30,
                      fontWeight: boldFontWeight,
                    ),
                  ),
                  const Text(
                    ".",
                    style: TextStyle(
                        color: yellowColor,
                        fontSize: 30,
                        fontWeight: boldFontWeight),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 65,
                decoration: BoxDecoration(
                  color: darkGreyColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: whiteColor,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: lightGreyColor),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle:
                              TextStyle(color: lightGreyColor.withOpacity(0.3)),
                        ),
                        cursorColor: whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Search results (0)",
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 18,
                  fontWeight: mediumFontWeight,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildSearchResultItem(),
            _buildSearchResultItem(),
            _buildSearchResultItem(),
            _buildSearchResultItem(),
            _buildSearchResultItem(),
            _buildSearchResultItem(),
          ],
        ),
      ]),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildSearchResultItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              color: lightGreyColor.withOpacity(0.4),
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Movie Title",
                  style: TextStyle(
                    color: whiteColor,
                    fontWeight: boldFontWeight,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    const Text(
                      "4.25",
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    buildRatingStars(4.25),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Action, Adventure, Sci-Fi",
                  style: TextStyle(
                    color: whiteColor.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed cursus enim vel commodo tristique.",
                  style: TextStyle(
                    color: whiteColor.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
