part of 'launch_screen_bloc.dart';

@immutable
abstract class LaunchScreenState {}

class LaunchScreenInitial extends LaunchScreenState {}

class LaunchScreenLoading extends LaunchScreenState {}

class LaunchScreenLoaded extends LaunchScreenState {
  final Map<String, dynamic> location;

  LaunchScreenLoaded({this.location = const {}});
}

class LaunchScreenError extends LaunchScreenState {}

