import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:wemovies/src/di/dependency_injection.dart';
import 'package:wemovies/src/services/local_storage_service.dart';

sealed class LocationService {
  Future<Placemark?> getLocation();
}

@Injectable(as: LocationService)
class LocationServiceImpl implements LocationService {
  @override
  Future<Placemark?> getLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return null;
    Position? position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    Placemark? placemark = await _getAddressFromLatLng(position);
    await getIt<LocalStorageService>().saveLocation(placemark);
    return placemark;
  }


  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<Placemark?> _getAddressFromLatLng(Position position) async {
    return (await placemarkFromCoordinates(
        position!.latitude, position!.longitude))[0];
  }
}
