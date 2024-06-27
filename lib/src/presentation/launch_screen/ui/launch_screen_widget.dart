import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemovies/src/presentation/launch_screen/bloc/launch_screen_bloc.dart';
import 'package:wemovies/src/presentation/movies_screen/ui/movies_screen_widget.dart';

class LaunchScreenWidget extends StatelessWidget {
  const LaunchScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: BlocProvider<LaunchScreenBloc>(
          create: (context) => LaunchScreenBloc()..add(FetchLocation()),
          child: BlocListener<LaunchScreenBloc, LaunchScreenState>(
              listener: (context, state) {
            if (state is LaunchScreenLoaded) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => NowPlayingMovies(
                          address: state.location,
                        )),
                (Route<dynamic> route) => false,
              );
            }
          }, child: BlocBuilder<LaunchScreenBloc, LaunchScreenState>(
                  builder: (context, state) {
            return switch (state) {
              LaunchScreenLoading() => Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(),
                        ),
                        child: Image.asset('assets/logo.png')),
                    Container(
                      height: 100,
                      width: 100,
                      child: const CircularProgressIndicator(
                        color: Colors.black,
                        strokeCap: StrokeCap.square,
                      ),
                    ),
                  ],
                ),
              LaunchScreenError() => const Text(("OOPS SOMETHING WENT WRONG")),
              _ =>  Text(state.toString())
            };
          })),
        ),
      ),
    );
  }
}
