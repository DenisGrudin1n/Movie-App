import 'package:flutter/material.dart';
import 'package:movieapp/constants.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/pages/movie_details_page.dart';
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
      body: Consumer<MoviesProvider>(
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
              return _buildBookmarkedMovieItem(movie, context);
            },
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildBookmarkedMovieItem(Movie movie, BuildContext context) {
    String genreNames = movie.genreNames.join(", ");

    String overview = movie.overview;
    bool isOverLength = overview.length > 200;
    overview = isOverLength ? '${overview.substring(0, 150)}...' : overview;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailPage(
              movie: movie,
              genreMap:
                  Provider.of<MoviesProvider>(context, listen: false).genreMap,
            ),
          ),
        );
      },
      child: Padding(
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
                    icon: const Icon(
                      Icons.bookmark,
                      color: yellowColor,
                      size: 28,
                    ),
                    onPressed: () {
                      Provider.of<MoviesProvider>(context, listen: false)
                          .toggleBookmark(
                              movie,
                              Provider.of<MoviesProvider>(context,
                                      listen: false)
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
        ),
      ),
    );
  }
}
