import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:meta/meta.dart';
import 'package:wemovies/src/util/location_util.dart';

import '../../movies_screen/ui/movies_screen_widget.dart';

part 'launch_screen_event.dart';

part 'launch_screen_state.dart';

class LaunchScreenBloc extends Bloc<LaunchScreenEvent, LaunchScreenState> {
  LaunchScreenBloc() : super(LaunchScreenInitial()) {
    on<FetchLocation>(_mapFecthEventToState);
  }

  String address = '';

  Future<void> _mapFecthEventToState(
      FetchLocation event, Emitter<LaunchScreenState> emit) async {
    emit(LaunchScreenLoading());
    Placemark? p;
    try {
      p = await _getCurrentPosition();
      print(p);
    } catch (e) {
      print('EROROORR$e');
    }
    emit(LaunchScreenLoaded(location: p?.toJson() ?? {}));
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<Placemark?> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return null;
    Position? position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    Placemark? placemark = await _getAddressFromLatLng(position);
    //     .then((Position position) {
    //   return _getAddressFromLatLng(position);
    // }).catchError((e) {
    //   return null;
    // });
    return placemark;
  }

  Future<Placemark?> _getAddressFromLatLng(Position position) async {
    return (await placemarkFromCoordinates(
        position!.latitude, position!.longitude))[0];
    //     .then((List<Placemark> placemarks) {
    //   Placemark place = placemarks[0];
    //   return place;
    // }).catchError((e) {
    //   debugPrint(e);
    // });
  }
}
