import 'package:flutter/material.dart';
import 'package:movieapp/constants.dart';
import 'package:movieapp/pages/home_page.dart';
import 'package:movieapp/providers/bottombar_navigation_provider.dart';
import 'package:movieapp/widgets/bottom_navigation_bar.dart';
import 'package:movieapp/widgets/build_rating_stars.dart';
import 'package:provider/provider.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

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
                      size: 28,
                      color: yellowColor,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    "Bookmarks",
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
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return _buildBookmarkItem();
              },
            ),
          ],
        ),
      ]),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildBookmarkItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: lightGreyColor,
                ),
                height: 300,
                width: 190,
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  icon: const Icon(
                    Icons.bookmark,
                    color: yellowColor,
                    size: 28,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Title",
                  style: TextStyle(
                      color: whiteColor,
                      fontWeight: boldFontWeight,
                      fontSize: 20.0),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    const Text(
                      "4.5",
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 20,
                        fontWeight: boldFontWeight,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    buildRatingStars(4.5),
                  ],
                ),
                const SizedBox(height: 10.0),
                const Text(
                  "Drama",
                  style: TextStyle(
                    color: whiteColor,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Overview",
                  style: TextStyle(
                    color: whiteColor.withOpacity(0.5),
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
