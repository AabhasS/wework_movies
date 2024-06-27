
import 'package:geocoding/geocoding.dart';

class LocationViewModel {
  final String name;
  final String details;

  LocationViewModel({required this.name, required this.details});

  static LocationViewModel fromPlacemark(Placemark? placemark) {
    return LocationViewModel(
        name: placemark?.name ?? '-', details: (placemark?.subLocality ?? '-')  + ','+ (placemark?.locality ?? '-'));
  }
}
