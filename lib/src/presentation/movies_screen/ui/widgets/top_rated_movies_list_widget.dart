import 'package:flutter/material.dart';
import 'package:wemovies/src/presentation/movies_screen/ui/widgets/top_rated_movies_widget.dart';
import 'package:wemovies/src/repositories/view_models/movie_view_model.dart';

import '../../../paginated_list_view/pagination_view.dart';

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
      onEmpty: const Center(child: Text("No Movies found!!")),
      onError: (e) => const Center(
          child: Text(
              "There was an error fetching the movies. Please try again!!")),
      initialLoader: const TopRatedMovieLoadingWidget(),
    );
  }
}
