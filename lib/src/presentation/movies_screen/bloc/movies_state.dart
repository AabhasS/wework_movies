part of 'movies_bloc.dart';

@immutable
abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final String query;
  MoviesLoaded({this.query = ''});
}

class MoviesEmpty extends MoviesState {}


class MoviesError extends MoviesState {
  final error;

  MoviesError({this.error});
}
