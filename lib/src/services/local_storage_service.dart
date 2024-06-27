import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemovies/src/di/dependency_injection.dart';
import 'package:wemovies/src/services/models/images.dart';
import 'package:wemovies/src/services/models/movie.dart';
import 'package:wemovies/src/services/movies_service.dart';
import 'package:wemovies/src/util/connectivity_check.dart';
import 'package:wemovies/src/util/constants.dart';

import 'models/configuration.dart';

sealed class LocalStorageService {
  Future<void> init();

  Future<void> saveMovies(String key, int pageNumber, List<dynamic> movies);

  List<Movie> getMovies(String key, int pageNumber);

  Future<void> saveLocation(Placemark? placemark);

  Future<Placemark?> getLocation();

  Future<void> saveConfig(Configuration config);

  Future<Configuration> getConfig();
}

@LazySingleton(as: LocalStorageService)
class LocalStorageServiceImpl implements LocalStorageService {
  late SharedPreferences prefs;

  @override
  List<Movie> getMovies(String key, int pageNumber) {
    String? moviesJson = prefs.getString('${key}_movies_page_$pageNumber');
    if (moviesJson != null) {
      List<dynamic> moviesList = jsonDecode(moviesJson);
      return moviesList.map((e) => Movie.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
   if(await ConnectivityService().isConnected()) {
      await getIt<MoviesService>().getImageConfigs();
    }
  }

  @override
  Future<void> saveMovies(String key, int pageNumber, List movies) async {
    List<String> storedPages = prefs.getStringList(
            '${key}_${AppConstants.storedPageLocalStorageKey}') ??
        [];

    if (!storedPages.contains(pageNumber.toString())) {
      String moviesJson = jsonEncode(movies);

      await prefs.setString('${key}_movies_page_$pageNumber', moviesJson);

      storedPages.add(pageNumber.toString());
      await prefs.setStringList(
          '${key}_${AppConstants.storedPageLocalStorageKey}', storedPages);
    }
  }

  @override
  Future<void> saveLocation(Placemark? placemark) async {
    await prefs.setString(
        AppConstants.locationLocalStorageKey, jsonEncode(placemark?.toJson()));
  }

  @override
  Future<Placemark?> getLocation() async {
    String? l = prefs.getString(AppConstants.locationLocalStorageKey);
    if (l != null) {
      return Placemark.fromMap(jsonDecode(l));
    }
    return null;
  }

  @override
  Future<void> saveConfig(Configuration configuration) async {
    await prefs.setString(AppConstants.locationLocalStorageKey,
        jsonEncode(configuration.toJson()));
  }

  @override
  Future<Configuration> getConfig() async {
    String? l = prefs.getString(AppConstants.locationLocalStorageKey);
    if (l != null) {
      return Configuration.fromJson(jsonDecode(l));
    }
    return Configuration(
        images: Images(
            baseUrl: "http://image.tmdb.org/t/p/",
            secureBaseUrl: "https://image.tmdb.org/t/p/",
            backdropSizes: [],
            logoSizes: [],
            posterSizes: [],
            profileSizes: [],
            stillSizes: []),
        changeKeys: []);
  }
}
