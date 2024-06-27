// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../repositories/location_repository.dart' as _i4;
import '../repositories/movies_repository.dart' as _i6;
import '../services/local_storage_service.dart' as _i3;
import '../services/location_service.dart' as _i5;
import '../services/movies_service.dart' as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.LocalStorageService>(
        () => _i3.LocalStorageServiceImpl());
    gh.factory<_i4.LocationRepository>(() => _i4.LocationRepositoryImpl());
    gh.factory<_i5.LocationService>(() => _i5.LocationServiceImpl());
    gh.factory<_i6.MoviesRepository>(() => _i6.MoviesRepositoryImpl());
    gh.factory<_i7.MoviesService>(() => _i7.MovieServiceImpl());
    return this;
  }
}
