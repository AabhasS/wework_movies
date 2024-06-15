import 'package:injectable/injectable.dart';
import 'package:wemovies/src/di/dependency_injection.dart';
import 'package:wemovies/src/repositories/view_models/location_view_model.dart';
import 'package:wemovies/src/services/location_service.dart';

sealed class LocationRepository {
  Future<LocationViewModel> fetchLocation();
}

@Injectable(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  @override
  Future<LocationViewModel> fetchLocation() async {
    var p = await getIt<LocationService>().getLocation();
    return LocationViewModel.fromPlacemark(p);
  }
}
