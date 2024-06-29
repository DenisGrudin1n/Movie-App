import 'package:flutter/material.dart';
import 'package:movieapp/constants.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/pages/home_page.dart';
import 'package:movieapp/pages/movie_details_page.dart';
import 'package:movieapp/providers/bottombar_navigation_provider.dart';
import 'package:movieapp/providers/movies_provider.dart';
import 'package:movieapp/widgets/bottom_navigation_bar.dart';
import 'package:movieapp/widgets/build_rating_stars.dart';
import 'package:provider/provider.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 65, 20, 20),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    var navigationProvider =
                        Provider.of<NavigationProvider>(context, listen: false);
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
          Expanded(
            child: Consumer<MoviesProvider>(
              builder: (context, moviesProvider, child) {
                if (moviesProvider.bookmarkedMovies.isEmpty) {
                  return const Center(
                    child: Text(
                      "No bookmarks yet",
                      style: TextStyle(color: whiteColor, fontSize: 20),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: moviesProvider.bookmarkedMovies.length,
                  itemBuilder: (context, index) {
                    final movie = moviesProvider.bookmarkedMovies[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailPage(
                              movie: movie,
                              genreMap: Provider.of<MoviesProvider>(context,
                                      listen: false)
                                  .genreMap,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: index == 0
                            ? const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 0.0)
                            : const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 30.0),
                        child: _buildBookmarkedMovieItem(movie, context),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildBookmarkedMovieItem(Movie movie, BuildContext context) {
    String genreNames = movie.genreNames.join(", ");

    String overview = movie.overview;
    bool isOverLength = overview.length > 200;
    overview = isOverLength ? '${overview.substring(0, 150)}...' : overview;

    return Row(
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
                icon: const Icon(
                  Icons.bookmark,
                  color: yellowColor,
                  size: 28,
                ),
                onPressed: () {
                  Provider.of<MoviesProvider>(context, listen: false)
                      .toggleBookmark(
                          movie,
                          Provider.of<MoviesProvider>(context, listen: false)
                              .genreMap);
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
                    fontSize: 20.0),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Text(
                    (movie.voteAverage / 2).toStringAsFixed(1),
                    style: const TextStyle(
                      color: whiteColor,
                      fontSize: 20,
                      fontWeight: boldFontWeight,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  buildRatingStars(movie.voteAverage / 2),
                ],
              ),
              const SizedBox(height: 10.0),
              Text(
                genreNames,
                style: const TextStyle(
                  color: whiteColor,
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
    );
  }
}
