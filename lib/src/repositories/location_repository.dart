import 'package:geocoding/geocoding.dart';
import 'package:injectable/injectable.dart';
import 'package:wemovies/src/di/dependency_injection.dart';
import 'package:wemovies/src/repositories/view_models/location_view_model.dart';
import 'package:wemovies/src/services/local_storage_service.dart';
import 'package:wemovies/src/services/location_service.dart';
import 'package:wemovies/src/util/connectivity_check.dart';

sealed class LocationRepository {
  Future<LocationViewModel> fetchLocation();
}

@Injectable(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  @override
  Future<LocationViewModel> fetchLocation() async {
    bool isConnected = await ConnectivityService().isConnected();
    Placemark? p;
    if (isConnected) {
      p = await getIt<LocationService>().getLocation();
    } else {
      p = await getIt<LocalStorageService>().getLocation();
    }
    return LocationViewModel.fromPlacemark(p);
  }
}
