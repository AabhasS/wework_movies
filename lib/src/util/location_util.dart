// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
//
// Future<bool> _handleLocationPermission(context) async {
//   bool serviceEnabled;
//   LocationPermission permission;
//
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text(
//             'Location services are disabled. Please enable the services')));
//     return false;
//   }
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Location permissions are denied')));
//       return false;
//     }
//   }
//   if (permission == LocationPermission.deniedForever) {
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text(
//             'Location permissions are permanently denied, we cannot request permissions.')));
//     return false;
//   }
//   return true;
// }
//
// Future<void> getCurrentPosition(c) async {
//   final hasPermission = await _handleLocationPermission(c);
//   if (!hasPermission) return;
//   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//       .then((Position position) {
//     _getAddressFromLatLng(position);
//   }).catchError((e) {
//     debugPrint(e);
//   });
// }
//
// Future<void> _getAddressFromLatLng(Position position) async {
//   await placemarkFromCoordinates(position.latitude, position.longitude)
//       .then((List<Placemark> placemarks) {
//     Placemark place = placemarks[0];
//     debugPrint(place.toString());
//   }).catchError((e) {
//     debugPrint(e);
//   });
// }
