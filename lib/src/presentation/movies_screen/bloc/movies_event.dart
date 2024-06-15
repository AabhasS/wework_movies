part of 'movies_bloc.dart';

@immutable
abstract class MoviesEvent {}

class FetchMovies extends MoviesEvent {
  final String searchQuery;

  FetchMovies({this.searchQuery = ''});
}
