import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movieapp/constants.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/screens/movie_details_page.dart';
import 'package:movieapp/widgets/build_rating_stars.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 40, 10, 20),
                child: Row(
                  children: [
                    Text(
                      "Top Five",
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ".",
                      style: TextStyle(
                          color: yellowColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              CarouselSlider.builder(
                itemCount: topMovies.length,
                options: CarouselOptions(
                  height: 270,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                  disableCenter: true,
                  viewportFraction: 0.7,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  reverse: false,
                  initialPage: 0,
                  aspectRatio: 16 / 9,
                ),
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  Movie movie = topMovies[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailPage(movie: movie),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.asset(
                            movie.posterPath,
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
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${movie.voteAverage}",
                                    style: const TextStyle(
                                      color: whiteColor,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  buildRatingStars(movie.voteAverage),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ".",
                            style: TextStyle(
                                color: yellowColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
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
              ...latestMovies.map(
                (movie) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailPage(movie: movie),
                        ),
                      );
                    },
                    child: _buildLatestMovieItem(movie)),
              ),
            ],
          ),
        ],
      ),
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
            child: Image.asset(
              movie.posterPath,
              fit: BoxFit.cover,
              height: 300,
              width: 190,
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
                    Text(
                      "${movie.voteAverage}",
                      style: const TextStyle(
                        color: whiteColor,
                        fontSize: 20,
                        fontWeight: boldFontWeight,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    buildRatingStars(movie.voteAverage),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  movie.genre,
                  style: TextStyle(
                    color: whiteColor.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  movie.overview,
                  style: TextStyle(
                    color: greyColor.withOpacity(0.85),
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
