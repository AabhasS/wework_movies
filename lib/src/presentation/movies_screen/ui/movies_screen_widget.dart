import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:wemovies/src/di/dependency_injection.dart';
import 'package:wemovies/src/presentation/movies_screen/bloc/movies_bloc.dart';
import 'package:wemovies/src/presentation/movies_screen/ui/top_rated_movies_widget.dart';
import 'package:wemovies/src/presentation/movies_screen/ui/widgets/address_widget.dart';
import 'package:wemovies/src/presentation/movies_screen/ui/widgets/now_playing_movies_list_widget.dart';
import 'package:wemovies/src/presentation/movies_screen/ui/widgets/top_rated_movies_list_widget.dart';
import 'package:wemovies/src/presentation/pag/pagination_view.dart';
import 'package:wemovies/src/repositories/movies_repository.dart';
import 'package:wemovies/src/repositories/view_models/movie_view_model.dart';
import 'package:wemovies/src/util/widgets/section_header.dart';

import 'now_playing_movie_widget.dart';

class NowPlayingMovies extends StatefulWidget {
  NowPlayingMovies({super.key, required this.address});

  final Map<String, dynamic> address;

  @override
  State<NowPlayingMovies> createState() => _NowPlayingMoviesState();
}

class _NowPlayingMoviesState extends State<NowPlayingMovies> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.5, 0.9],
          colors: [
            Color(0xffA78EA5),
            Color(0xffE2D1E1), // Intermediate color 2
            Color(0xffF0EFEF),
          ],
        ),
      ),
      child: BlocProvider(
        create: (context) => MoviesBloc(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  title: AddressWidget(
                      placemark: Placemark.fromMap(widget.address)),
                  pinned: true,
                  floating: true,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image.asset('assets/we.png'),
                      ),
                    )
                  ],
                  forceElevated: innerBoxIsScrolled,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(88.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 16),
                      child: SearchBar(
                        elevation: const MaterialStatePropertyAll<double>(0),
                        leading: Icon(
                          Icons.search_rounded,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        hintText: 'Search Movies by name...',
                        hintStyle: MaterialStatePropertyAll<TextStyle?>(
                            Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w300)),
                        onChanged: (s) {
                          setState(() {
                            searchQuery = s;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SectionHeaderWidget(title: 'NOW PLAYING'),
                  SizedBox(
                    height: 300,
                    child: NowPlayingMoviesWidget(
                        moviesFuture: (page) =>
                            BlocProvider.of<MoviesBloc>(context)
                                .moviesRepository
                                .fetchTopRatedMovies(
                                    page: page, searchQuery: searchQuery)),
                  ),
                  const SectionHeaderWidget(title: 'TOP RATED'),
                  Expanded(
                    flex: 3,
                    child: TopRatedMoviesWidget(moviesFuture: (page) {
                      return BlocProvider.of<MoviesBloc>(context)
                          .moviesRepository
                          .fetchTopRatedMovies(
                              page: page, searchQuery: searchQuery);
                    }),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedIconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: const Color(0xffF0EFEF),
            currentIndex: 0,
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/we.png',
                    height: 20,
                  ),
                  label: 'We movies'),
              const BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined),
                label: 'Explore',
              ),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month), label: 'Upcoming')
            ],
          ),
        ),
      ),
    );
  }
}
