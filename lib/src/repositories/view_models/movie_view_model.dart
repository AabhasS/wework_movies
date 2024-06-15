import 'package:wemovies/src/services/models/movie.dart';
import 'package:wemovies/src/util/extensions.dart';

class MovieViewModel {
  final String title;
  final String overview;
  final String votes;
  final String views;
  final String language;
  final String url;
  final String avgRating;

  MovieViewModel({required this.title,
    required this.overview,
    required this.votes,
    required this.views,
    required this.language, this.url = '', this.avgRating = '-'});

  static MovieViewModel fromMovie(Movie movie) {
    return MovieViewModel(title: movie.title,
        overview: movie.overview,
        votes: movie.voteCount.toShortString(),
        views: movie.popularity.toShortString(),
        avgRating: movie.voteAverage.toStringAsFixed(2),
        language: movie.originalLanguage.toLanguageName(), url: 'https://image.tmdb.org/t/p/w500${movie.posterPath}');
  }
}
