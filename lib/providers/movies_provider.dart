import 'package:flutter/material.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/services/movie_service.dart';

class MoviesProvider with ChangeNotifier {
  final MovieService _movieService = MovieService();

  List<Movie> _topMovies = [];
  List<Movie> _latestMovies = [];
  List<Movie> _searchResults = [];
  Map<int, String> _genreMap = {};
  final Set<int> _bookmarkedMovieIds = {};
  bool _isLoading = false;

  List<Movie> get topMovies => _topMovies;
  List<Movie> get latestMovies => _latestMovies;
  List<Movie> get searchResults => _searchResults;
  Map<int, String> get genreMap => _genreMap;
  Set<int> get bookmarkedMovieIds => _bookmarkedMovieIds;
  bool get isLoading => _isLoading;

  MoviesProvider() {
    getTopRatedMovies();
    getLatestMovies();
    loadGenres();
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

  Future<void> searchMovies(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _searchResults = await _movieService.searchMovies(query);
    } catch (error) {
      // Handle error
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadGenres() async {
    try {
      _genreMap = await _movieService.getGenres();
      notifyListeners();
    } catch (error) {
      // Handle error
    }
  }

  void toggleBookmark(int movieId) {
    if (_bookmarkedMovieIds.contains(movieId)) {
      _bookmarkedMovieIds.remove(movieId);
    } else {
      _bookmarkedMovieIds.add(movieId);
    }
    notifyListeners();
  }
}
