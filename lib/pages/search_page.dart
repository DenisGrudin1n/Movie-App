import 'package:flutter/material.dart';
import 'package:movieapp/constants.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/providers/bottombar_navigation_provider.dart';
import 'package:movieapp/providers/movies_provider.dart';
import 'package:movieapp/pages/home_page.dart';
import 'package:movieapp/pages/movie_details_page.dart';
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
                      size: 28,
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
                          hintStyle: TextStyle(
                            color: lightGreyColor.withOpacity(0.3),
                            fontSize: 18,
                          ),
                        ),
                        cursorColor: whiteColor,
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            var moviesProvider = Provider.of<MoviesProvider>(
                                context,
                                listen: false);
                            moviesProvider.searchMovies(value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Consumer<MoviesProvider>(
              builder: (context, moviesProvider, _) {
                final searchResults = moviesProvider.searchResults;
                final genreMap = moviesProvider.genreMap;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Search results (${searchResults.length})",
                        style: const TextStyle(
                          color: whiteColor,
                          fontSize: 18,
                          fontWeight: mediumFontWeight,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final movie = searchResults[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailPage(
                                    movie: movie, genreMap: genreMap),
                              ),
                            );
                          },
                          child:
                              _buildSearchResultItem(movie, genreMap, context),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ]),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildSearchResultItem(
      Movie movie, Map<int, String> genreMap, BuildContext context) {
    String overview = movie.overview;
    bool isOverLength = overview.length > 200;
    overview = isOverLength ? '${overview.substring(0, 150)}...' : overview;

    bool isBookmarked =
        Provider.of<MoviesProvider>(context).isBookmarked(movie.id);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child: Image.network(
                  "https://image.tmdb.org/t/p/original/${movie.posterPath}",
                  fit: BoxFit.cover,
                  height: 300,
                  width: 190,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      height: 300,
                      width: 190,
                      child: Center(
                        child: Text(
                          "No Image",
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: isBookmarked ? yellowColor : whiteColor,
                    size: 28,
                  ),
                  onPressed: () {
                    Provider.of<MoviesProvider>(context, listen: false)
                        .toggleBookmark(movie, genreMap);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    color: whiteColor,
                    fontWeight: boldFontWeight,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Text(
                      (movie.voteAverage / 2).toStringAsFixed(1),
                      style: const TextStyle(
                        color: whiteColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    buildRatingStars(movie.voteAverage / 2),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  _buildGenres(movie.genreIds, genreMap),
                  style: TextStyle(
                    color: whiteColor.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  overview,
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

  String _buildGenres(List<int> genreIds, Map<int, String> genreMap) {
    List<String> genres =
        genreIds.map((id) => genreMap[id] ?? 'Unknown').toList();
    return genres.join(', ');
  }
}
