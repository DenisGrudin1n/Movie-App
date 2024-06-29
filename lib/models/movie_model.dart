class Movie {
  final int id;
  final String title;
  final List<int> genreIds;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final String releaseDate;
  final List<String> genreNames;

  Movie({
    required this.id,
    required this.title,
    required this.genreIds,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.genreNames,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 'Unknown',
      title: json['title'] ?? 'Unknown',
      genreIds: List<int>.from(json['genre_ids']),
      overview: json['overview'] ?? 'Unknown',
      posterPath: json['poster_path'] ?? 'Unknown',
      backdropPath: json['backdrop_path'] ?? 'Unknown',
      voteAverage: (json['vote_average'] as num).toDouble(),
      releaseDate: json['release_date'],
      genreNames: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'vote_average': voteAverage,
      'overview': overview,
      'genreIds': genreIds,
      'release_date': releaseDate,
      'genre_names': genreNames,
    };
  }
}
