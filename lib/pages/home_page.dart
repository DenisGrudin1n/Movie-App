import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movieapp/constants.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/providers/movies_provider.dart';
import 'package:movieapp/pages/movie_details_page.dart';
import 'package:movieapp/widgets/bottom_navigation_bar.dart';
import 'package:movieapp/widgets/build_rating_stars.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 40, 20, 20),
                child: Row(
                  children: [
                    Text(
                      "Top Five",
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 30,
                          fontWeight: boldFontWeight),
                    ),
                    Text(
                      ".",
                      style: TextStyle(
                          color: yellowColor,
                          fontSize: 30,
                          fontWeight: boldFontWeight),
                    ),
                  ],
                ),
              ),
              Consumer<MoviesProvider>(
                builder: (context, moviesProvider, child) {
                  if (moviesProvider.isLoading ||
                      moviesProvider.topMovies.isEmpty ||
                      moviesProvider.genreMap.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return CarouselSlider.builder(
                      itemCount: moviesProvider.topMovies.length > 5
                          ? 5
                          : moviesProvider.topMovies.length,
                      options: CarouselOptions(
                        height: 270,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        disableCenter: true,
                        viewportFraction: 0.7,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        reverse: false,
                        initialPage: 0,
                        aspectRatio: 16 / 9,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        final movie = moviesProvider.topMovies[index];
                        String movieVoteInString =
                            movie.voteAverage.toStringAsFixed(1);
                        double movieVoteInDouble =
                            double.parse(movieVoteInString);
                        bool isBookmarked =
                            moviesProvider.isBookmarked(movie.id);
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailPage(
                                  movie: movie,
                                  genreMap: moviesProvider.genreMap,
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Image.network(
                                      "https://image.tmdb.org/t/p/original/${movie.backdropPath}",
                                      fit: BoxFit.cover,
                                      height: 180,
                                      width: 350,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, top: 8, bottom: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title,
                                          style: const TextStyle(
                                            color: whiteColor,
                                            fontWeight: boldFontWeight,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              (movie.voteAverage / 2)
                                                  .toStringAsFixed(1),
                                              style: const TextStyle(
                                                color: whiteColor,
                                                fontSize: 17,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            buildRatingStars(
                                                movieVoteInDouble / 2),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: IconButton(
                                  icon: Icon(
                                    isBookmarked
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color:
                                        isBookmarked ? yellowColor : whiteColor,
                                    size: 28,
                                  ),
                                  onPressed: () {
                                    Provider.of<MoviesProvider>(context,
                                            listen: false)
                                        .toggleBookmark(
                                            movie, moviesProvider.genreMap);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      "Latest",
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 30,
                        fontWeight: boldFontWeight,
                      ),
                    ),
                    Text(
                      ".",
                      style: TextStyle(
                          color: yellowColor,
                          fontSize: 30,
                          fontWeight: boldFontWeight),
                    ),
                  ],
                ),
              ),
              Consumer<MoviesProvider>(
                builder: (context, moviesProvider, child) {
                  if (moviesProvider.isLoading ||
                      moviesProvider.latestMovies.isEmpty ||
                      moviesProvider.genreMap.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      children: List.generate(
                        6,
                        (index) {
                          final movie = moviesProvider.latestMovies[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailPage(
                                    movie: movie,
                                    genreMap: moviesProvider.genreMap,
                                  ),
                                ),
                              );
                            },
                            child: _buildLatestMovieItem(
                                movie, moviesProvider.genreMap, context),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildLatestMovieItem(
      Movie movie, Map<int, String> genres, BuildContext context) {
    String genreNames = movie.genreIds.map((id) => genres[id]).join(", ");

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
                        .toggleBookmark(movie, genres);
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
    );
  }
}
