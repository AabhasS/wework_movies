import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

sealed class LocalStorageService {
  Future<void> init();

  Future<void> _saveMovies(String key, int pageNumber, List<dynamic> movies);

  List<dynamic> _getMovies(String key, int pageNumber);

  Future<List<dynamic>> saveAndGetMovies(
      String key, int pageNumber, List<dynamic> movies);
}

class LocalStorageServiceImpl implements LocalStorageService {
  late SharedPreferences prefs;
  static const String _storedPagesKey = 'storedPages';

  @override
  List<dynamic> _getMovies(String key, int pageNumber) {
    String? moviesJson = prefs.getString('${key}_movies_page_$pageNumber');
    if (moviesJson != null) {
      List<dynamic> moviesList = jsonDecode(moviesJson);
      return moviesList;
    }
    return [];
  }

  @override
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> _saveMovies(String key, int pageNumber, List movies) async {
    List<String> storedPages = prefs.getStringList(_storedPagesKey) ?? [];

    if (!storedPages.contains(pageNumber.toString())) {
      String moviesJson = jsonEncode(movies);

      await prefs.setString('${key}_movies_page_$pageNumber', moviesJson);

      storedPages.add(pageNumber.toString());
      await prefs.setStringList(_storedPagesKey, storedPages);
    }
  }

  @override
  Future<List> saveAndGetMovies(
      String key, int pageNumber, List<dynamic> movies) async {
    await _saveMovies(key, pageNumber, movies);
    List storedMovies = _getMovies(key, pageNumber);
    return storedMovies;
  }
}
