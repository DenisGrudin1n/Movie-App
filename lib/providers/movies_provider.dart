import 'package:flutter/material.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/services/movie_service.dart';

class MoviesProvider with ChangeNotifier {
  final MovieService _movieService = MovieService();

  List<Movie> _topMovies = [];
  List<Movie> _latestMovies = [];
  bool _isLoading = false;

  List<Movie> get topMovies => _topMovies;
  List<Movie> get latestMovies => _latestMovies;
  bool get isLoading => _isLoading;

  MoviesProvider() {
    getTopRatedMovies();
  }

  Future<void> getTopRatedMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      _topMovies = await _movieService.getTopRatedMovies();
    } catch (error) {
      // Handle error
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getLatestMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      _latestMovies = await _movieService.getLatestMovies();
    } catch (error) {
      // Handle error
    }

    _isLoading = false;
    notifyListeners();
  }
}
