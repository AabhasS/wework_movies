part of 'launch_screen_bloc.dart';

@immutable
abstract class LaunchScreenState {}

class LaunchScreenInitial extends LaunchScreenState {}

class LaunchScreenLoading extends LaunchScreenState {}

class LaunchScreenLoaded extends LaunchScreenState {
  final LocationViewModel location;

  LaunchScreenLoaded({required this.location});
}

class LaunchScreenError extends LaunchScreenState {}

