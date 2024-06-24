import 'package:flutter/material.dart';
import 'package:movieapp/constants.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/widgets/build_rating_stars.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: blackColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  height: screenHeight * 2 / 3,
                  width: screenWidth,
                ),
                Container(
                  height: screenHeight * 2 / 3,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.2],
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 16,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 35,
                      color: whiteColor,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 16,
                  right: 16,
                  child: Text(
                    movie.title,
                    style: const TextStyle(
                      color: whiteColor,
                      fontWeight: boldFontWeight,
                      fontSize: 36.0,
                      shadows: [
                        Shadow(
                          offset: Offset(0.0, 0.0),
                          blurRadius: 6.0,
                          color: blackColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${movie.voteAverage}",
                        style: const TextStyle(
                          color: whiteColor,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      buildRatingStars(movie.voteAverage),
                    ],
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    movie.genre,
                    style: TextStyle(
                      color: whiteColor.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    movie.overview,
                    style: TextStyle(
                      color: greyColor.withOpacity(0.85),
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    "Read More",
                    style: TextStyle(
                      color: yellowColor,
                      fontSize: 18,
                      fontWeight: boldFontWeight,
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
