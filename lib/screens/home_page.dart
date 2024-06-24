import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movieapp/constants.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/screens/movie_details_page.dart';
import 'package:movieapp/services/movie_service.dart';
import 'package:movieapp/widgets/bottom_navigation_bar.dart';
import 'package:movieapp/widgets/build_rating_stars.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> latestMovies;

  @override
  void initState() {
    topRatedMovies = MovieService().getTopRatedMovies();
    latestMovies = MovieService().getLatestMovies();
    super.initState();
  }

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
              FutureBuilder(
                future: topRatedMovies,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final movies = snapshot.data!;
                  return CarouselSlider.builder(
                    itemCount: movies.length > 5 ? 5 : movies.length,
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
                      final movie = movies[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailPage(movie: movie),
                            ),
                          );
                        },
                        child: Column(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      const Text(
                                        "4.0", // Const value for rating
                                        style: TextStyle(
                                          color: whiteColor,
                                          fontSize: 17,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      buildRatingStars(
                                          4.0), // Const value for rating stars
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
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
                    Text(
                      "SEE MORE",
                      style: TextStyle(
                        color: yellowColor,
                        fontSize: 14,
                        fontWeight: mediumFontWeight,
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: latestMovies,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final movies = snapshot.data!;
                  return Column(
                    children: List.generate(
                      6,
                      (index) {
                        final movie = movies[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailPage(movie: movie),
                              ),
                            );
                          },
                          child: _buildLatestMovieItem(movie),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildLatestMovieItem(Movie movie) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              },
            ),
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
                    const Text(
                      "4.0", // Const value for rating
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 20,
                        fontWeight: boldFontWeight,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    buildRatingStars(4.0), // Const value for rating stars
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Drama", // Const value for genre
                  style: TextStyle(
                    color: whiteColor.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  movie.overview,
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
