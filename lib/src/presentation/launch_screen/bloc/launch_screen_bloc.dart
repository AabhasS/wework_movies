import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:meta/meta.dart';
import 'package:wemovies/src/di/dependency_injection.dart';
import 'package:wemovies/src/repositories/location_repository.dart';
import 'package:wemovies/src/repositories/view_models/location_view_model.dart';
import 'package:wemovies/src/util/location_util.dart';

import '../../movies_screen/ui/movies_screen_widget.dart';

part 'launch_screen_event.dart';

part 'launch_screen_state.dart';

class LaunchScreenBloc extends Bloc<LaunchScreenEvent, LaunchScreenState> {
  LaunchScreenBloc() : super(LaunchScreenInitial()) {
    on<FetchLocation>(_mapFetchEventToState);
  }

  String address = '';

  Future<void> _mapFetchEventToState(
      FetchLocation event, Emitter<LaunchScreenState> emit) async {
    emit(LaunchScreenLoading());
    late LocationViewModel p;
    try {
      p = await getIt<LocationRepository>().fetchLocation();
    } catch (e) {
      emit(LaunchScreenError());
    }
    emit(LaunchScreenLoaded(location: p));
  }
}
