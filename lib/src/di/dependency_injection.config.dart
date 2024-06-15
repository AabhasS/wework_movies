// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../repositories/location_repository.dart' as _i3;
import '../repositories/movies_repository.dart' as _i5;
import '../services/location_service.dart' as _i4;
import '../services/movies_service.dart' as _i6;

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
    gh.factory<_i3.LocationRepository>(() => _i3.LocationRepositoryImpl());
    gh.factory<_i4.LocationService>(() => _i4.LocationServiceImpl());
    gh.factory<_i5.MoviesRepository>(() => _i5.MoviesRepositoryImpl());
    gh.factory<_i6.MoviesService>(() => _i6.MovieServiceImpl());
    return this;
  }
}
