import 'package:flutter/material.dart';
import 'package:wemovies/src/presentation/movies_screen/ui/widgets/now_playing_movie_widget.dart';
import 'package:wemovies/src/repositories/view_models/movie_view_model.dart';

import '../../../paginated_list_view/pagination_view.dart';

class NowPlayingMoviesWidget extends StatelessWidget {
  const NowPlayingMoviesWidget({super.key, required this.moviesFuture});

  final Future<List<MovieViewModel>> Function(int) moviesFuture;

  @override
  Widget build(BuildContext context) {
    return PaginationView<MovieViewModel>(
       pullToRefresh: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, item, i) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: NowPlayingMovieWidget(movie: item),
        );
      },
      pageFetch: (offset, pagenumber) async {
        return moviesFuture(pagenumber + 1);
      },
      initialLoader: const NowPlayingMovieLoadingWidget(),
      onEmpty: const Center(child: Text("No Movies are playing right now!!")),
      onError: (e) => const Center(
          child: Text(
              "There was an error fetching the movies. Please try again!!")),
    );
  }
}
