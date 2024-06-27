import 'package:injectable/injectable.dart';
import 'package:wemovies/src/di/dependency_injection.dart';
import 'package:wemovies/src/repositories/view_models/movie_view_model.dart';
import 'package:wemovies/src/services/local_storage_service.dart';
import 'package:wemovies/src/services/models/movie.dart';
import 'package:wemovies/src/services/movies_service.dart';
import 'package:wemovies/src/util/constants.dart';

import '../util/connectivity_check.dart';

sealed class MoviesRepository {
  Future<List<MovieViewModel>> fetchNowPlayingMovies(
      {int page = 1, String searchQuery = ''});

  Future<List<MovieViewModel>> fetchTopRatedMovies(
      {int page = 1, String searchQuery = ''});

// Future fetchConfig();
}

@Injectable(as: MoviesRepository)
class MoviesRepositoryImpl implements MoviesRepository {
  @override
  Future<List<MovieViewModel>> fetchNowPlayingMovies(
      {int page = 1, String searchQuery = ''}) async {
    List<Movie> movies = [];
    bool isConnected = await ConnectivityService().isConnected();
    if (isConnected) {
      movies = await getIt<MoviesService>().getNowPlayingMovies(page: page);
    } else {
      movies =  getIt<LocalStorageService>()
          .getMovies(AppConstants.nowPlayingLocalStorageKey, page);
    }
    return movies
        .map((movie) => MovieViewModel.fromMovie(movie))
        .where((element) =>
            element.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Future<List<MovieViewModel>> fetchTopRatedMovies(
      {int page = 1, String searchQuery = ''}) async {
    List<Movie> movies = [];
    bool isConnected = await ConnectivityService().isConnected();
    if (isConnected) {
      movies = await getIt<MoviesService>().getTopRatedMovies(page: page);
    } else {
      movies =  getIt<LocalStorageService>()
          .getMovies(AppConstants.topRatedLocalStorageKey, page);
    }
    return movies
        .map((movie) => MovieViewModel.fromMovie(movie))
        .where((element) =>
            element.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }
}
