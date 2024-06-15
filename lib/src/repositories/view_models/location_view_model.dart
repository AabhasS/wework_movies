
class LocationViewModel {
  final String name;
  final String details;

  LocationViewModel({required this.name, required this.details});

  static LocationViewModel fromPlacemark(var placemark) {
    return LocationViewModel(
        name: placemark.name ?? '-', details: placemark.locality ?? '-');
  }
}
