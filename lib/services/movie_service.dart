import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movieapp/constants.dart';
import 'package:movieapp/models/movie_model.dart';

class MovieService {
  final topRatedUrl =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey";
  final latestUrl = "https://api.themoviedb.org/3/discover/movie";

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(
      Uri.parse(topRatedUrl),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      List<Movie> movies =
          data.map((movieJson) => Movie.fromJson(movieJson)).toList();
      return movies;
    } else {
      throw Exception('Failed to load top movies');
    }
  }

  Future<List<Movie>> getLatestMovies() async {
    final currentDate = DateTime.now().toIso8601String();
    final url = Uri.parse(
        '$latestUrl?api_key=$apiKey&sort_by=release_date.desc&primary_release_date.lte=$currentDate');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      List<Movie> movies =
          data.map((movieJson) => Movie.fromJson(movieJson)).where((movie) {
        if (movie.releaseDate.isNotEmpty) {
          return DateTime.parse(movie.releaseDate).isBefore(DateTime.now()) ||
              DateTime.parse(movie.releaseDate)
                  .isAtSameMomentAs(DateTime.now());
        }
        return false;
      }).toList();
      return movies;
    } else {
      throw Exception('Failed to load latest movies');
    }
  }
}
