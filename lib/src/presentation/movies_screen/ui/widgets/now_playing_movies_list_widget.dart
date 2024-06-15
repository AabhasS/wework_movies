
import 'package:flutter/material.dart';
import 'package:wemovies/src/presentation/movies_screen/ui/now_playing_movie_widget.dart';
import 'package:wemovies/src/presentation/pag/pagination_view.dart';
import 'package:wemovies/src/repositories/view_models/movie_view_model.dart';

class NowPlayingMoviesWidget extends StatelessWidget {
  const NowPlayingMoviesWidget({super.key,  required this.moviesFuture });
  final Future<List<MovieViewModel>> Function(int) moviesFuture;
  @override
  Widget build(BuildContext context) {
    return PaginationView<MovieViewModel>(
      // pullToRefresh: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, item, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: NowPlayingMovieWidget(movie: item),
          );
        },
        pageFetch: (offset, pagenumber) async {
          print('NOW PLAYInG $offset , $pagenumber');
          return moviesFuture(pagenumber+1);
        },
        onEmpty: Text("NO DATA"),
        onError: (e) => Text('ERRORRRRR'));
  }
}
