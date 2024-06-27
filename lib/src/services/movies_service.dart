import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:wemovies/src/di/dependency_injection.dart';
import 'package:wemovies/src/services/local_storage_service.dart';
import 'package:wemovies/src/services/models/movie.dart';
import 'package:wemovies/src/util/constants.dart';

sealed class MoviesService {
  Future<List<Movie>> getNowPlayingMovies({int page = 1});

  Future<List<Movie>> getTopRatedMovies({int page = 1});

  Future getImageConfigs();
}

@Injectable(as: MoviesService)
class MovieServiceImpl implements MoviesService {
  Dio dio = Dio();

  MovieServiceImpl() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add a custom header to the request
          options.headers['Authorization'] =
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2YTg3ZTY4MDMyODIwMTIzZmQ0Yzg0YjQzNDhjYjc3ZCIsInN1YiI6IjY2Mjg5NDExOTFmMGVhMDE0YjAwOWU1ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6zIM73Giwg5M4wP6MX8KDCpee7IMnpnLTZUyMpETb08';
          options.headers['accept'] = 'application/json';
          return handler.next(options);
        },
      ),
    );
  }

  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    var res = await dio.get(
        'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=$page');
    List<dynamic> movies = res.data['results'] as List<dynamic>;
    await getIt<LocalStorageService>().saveMovies(AppConstants.nowPlayingLocalStorageKey, page, movies);
    return movies.map((e) => Movie.fromJson(e)).toList();
  }

  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1}) async {
    var res = await dio.get(
        'https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=$page');
    List<dynamic> movies = res.data['results'] as List<dynamic>;
    await getIt<LocalStorageService>().saveMovies(AppConstants.topRatedLocalStorageKey, page, movies);
    return movies.map((e) => Movie.fromJson(e)).toList();
  }

  @override
  Future getImageConfigs() async {
    var res = await dio.get('https://api.themoviedb.org/3/configuration');
    return res;
  }
}
