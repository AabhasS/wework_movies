import 'package:flutter/material.dart';
import 'package:wemovies/src/presentation/movies_screen/ui/top_rated_movies_widget.dart';
import 'package:wemovies/src/repositories/view_models/movie_view_model.dart';

import '../../../pag/pagination_view.dart';

class TopRatedMoviesWidget extends StatelessWidget {
  const TopRatedMoviesWidget({super.key, required this.moviesFuture});

  final Future<List<MovieViewModel>> Function(int) moviesFuture;

  @override
  Widget build(BuildContext context) {
    return PaginationView<MovieViewModel>(
      pullToRefresh: true,
      itemBuilder: (context, item, i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: TopRatedMovieWidget(
            movieViewModel: item,
          ),
        );
      },
      pageFetch: (offset, pagenumber) {
        return moviesFuture(pagenumber + 1);
      },
      onEmpty: Text("NO DATA"),
      onError: (e) => Text('ERRORRRRR'),
      initialLoader: TopRatedMovieLoadingWidget(),
    );
  }
}
