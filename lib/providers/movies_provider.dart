import 'package:flutter/material.dart';
import 'package:movieapp/models/movie_model.dart';

class MoviesProvider with ChangeNotifier {
  List<Movie> _topMovies = [];
  List<Movie> _latestMovies = [];

  List<Movie> get topMovies => _topMovies;
  List<Movie> get latestMovies => _latestMovies;

  void updateTopMovies(List<Movie> movies) {
    _topMovies = movies;
    notifyListeners();
  }

  void updateLatestMovies(List<Movie> movies) {
    _latestMovies = movies;
    notifyListeners();
  }
}
