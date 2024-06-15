import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wemovies/src/di/dependency_injection.dart';
import 'package:wemovies/src/repositories/movies_repository.dart';

part 'movies_event.dart';

part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial()) {
    on<FetchMovies>(_mapFetchEventToState);
  }

  MoviesRepository moviesRepository = getIt<MoviesRepository>();

  Future<FutureOr<void>> _mapFetchEventToState(
      FetchMovies event, Emitter<MoviesState> emit) async {
    emit(MoviesLoading());
  }
}
