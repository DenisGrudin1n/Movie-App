import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movieapp/constants.dart';
import 'package:movieapp/models/movie_model.dart';

class MovieService {
  final topRatedUrl =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey";
  final latestUrl = "https://api.themoviedb.org/3/discover/movie";
  final genresUrl =
      "https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=en-US";
  final searchUrl = "https://api.themoviedb.org/3/search/movie";

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
        '$latestUrl?api_key=$apiKey&sort_by=release_date.desc&vote_average.gte=1.0&primary_release_date.lte=$currentDate');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      List<Movie> movies =
          data.map((movieJson) => Movie.fromJson(movieJson)).where((movie) {
        return movie.voteAverage > 0.0 && movie.releaseDate.isNotEmpty;
      }).toList();
      return movies;
    } else {
      throw Exception('Failed to load latest movies');
    }
  }

  Future<Map<int, String>> getGenres() async {
    final response = await http.get(Uri.parse(genresUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['genres'];
      Map<int, String> genres = {
        for (var genre in data) genre['id']: genre['name']
      };
      return genres;
    } else {
      throw Exception('Failed to load genres');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.parse('$searchUrl?api_key=$apiKey&query=$query');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      List<Movie> movies =
          data.map((movieJson) => Movie.fromJson(movieJson)).toList();
      return movies;
    } else {
      throw Exception('Failed to search movies');
    }
  }
}
