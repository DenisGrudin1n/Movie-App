import 'package:flutter/material.dart';
import 'package:movieapp/constants.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/providers/movies_provider.dart';
import 'package:movieapp/widgets/build_rating_stars.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  final Map<int, String> genreMap;

  const MovieDetailPage(
      {super.key, required this.movie, required this.genreMap});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  bool showFullOverview = false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    bool isBookmarked =
        Provider.of<MoviesProvider>(context).isBookmarked(widget.movie.id);

    List<String> genreNames = widget.movie.genreIds
        .map((id) => widget.genreMap[id] ?? 'Unknown')
        .toList();

    String overview = widget.movie.overview;
    bool isOverLength = overview.length > 200;

    const readMoreText = TextSpan(
      text: ' Read More',
      style: TextStyle(
        color: yellowColor,
        fontSize: 18,
        fontWeight: boldFontWeight,
      ),
    );

    overview = isOverLength ? '${overview.substring(0, 175)}... ' : overview;

    return Scaffold(
      backgroundColor: blackColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  "https://image.tmdb.org/t/p/original/${widget.movie.posterPath}",
                  fit: BoxFit.cover,
                  height: screenHeight * 2 / 3,
                  width: screenWidth,
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(
                      height: screenHeight * 2 / 3,
                      width: screenWidth,
                      child: const Center(
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
                Container(
                  height: screenHeight * 2 / 3,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        blackColor.withOpacity(0.9),
                        transparentColor,
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
                      size: 28,
                      color: whiteColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  right: 16,
                  child: Consumer<MoviesProvider>(
                    builder: (context, moviesProvider, child) {
                      return IconButton(
                        icon: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: isBookmarked ? yellowColor : whiteColor,
                          size: 28,
                        ),
                        onPressed: () {
                          Provider.of<MoviesProvider>(context, listen: false)
                              .toggleBookmark(widget.movie, widget.genreMap);
                        },
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 16,
                  right: 16,
                  child: Text(
                    widget.movie.title,
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
                        (widget.movie.voteAverage / 2).toStringAsFixed(1),
                        style: const TextStyle(
                          color: whiteColor,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      buildRatingStars(widget.movie.voteAverage / 2),
                    ],
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    genreNames.join(', '),
                    style: const TextStyle(
                      color: whiteColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showFullOverview = !showFullOverview;
                      });
                    },
                    child: RichText(
                      text: TextSpan(
                        text:
                            showFullOverview ? widget.movie.overview : overview,
                        style: TextStyle(
                          color: whiteColor.withOpacity(0.5),
                          fontSize: 18,
                        ),
                        children: isOverLength
                            ? [
                                if (!showFullOverview) readMoreText,
                              ]
                            : [],
                      ),
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
