import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wemovies/src/repositories/view_models/movie_view_model.dart';

class NowPlayingMovieWidget extends StatelessWidget {
  const NowPlayingMovieWidget(
      {super.key, required this.movie, this.borderRadius = 20});

  final MovieViewModel movie;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      //clipper: MyCustomClipper(),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
        child: Container(
          width: 250,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(borderRadius)),
          padding: EdgeInsets.all(8),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: CachedNetworkImage(
                  errorWidget: (context, e, _) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(color: Colors.white,)),
                  imageUrl: movie.url,
                  fit: BoxFit.cover,
                  width: 250,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius:
                                  BorderRadius.circular(borderRadius)),
                          child: Text(
                            '${movie.avgRating} ⭐',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius:
                                      BorderRadius.circular(borderRadius)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  Text(
                                    movie.views,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius:
                                      BorderRadius.circular(borderRadius)),
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.8),
                            Colors.grey.withOpacity(0.8)
                          ]),
                      borderRadius: BorderRadius.circular(borderRadius)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          movie.language,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      Text(
                        movie.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        movie.overview,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${movie.votes} Votes',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NowPlayingMovieLoadingWidget extends StatelessWidget {
  const NowPlayingMovieLoadingWidget({super.key, this.borderRadius = 20});

  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(
          2,
          (index) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 300,
                width: 250,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(borderRadius)),
              ))),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  double radius = 50;

  @override
  getClip(Size size) {
    double dist = radius * 2;
    Path path = Path();
    path
      ..moveTo(radius, dist)
      ..lineTo((size.width / 2) - radius, 0)
      ..arcToPoint(Offset(size.width / 2, dist - radius),
          radius: Radius.circular(radius))
      ..lineTo(size.width / 2, radius)
      ..arcToPoint(Offset(size.width / 2 + radius, 0),
          radius: Radius.circular(radius), clockwise: false)
      ..lineTo(size.width - radius, 0)
      ..arcToPoint(
        Offset(size.width, radius),
        radius: Radius.circular(radius),
      )
      ..lineTo(size.width, size.height - radius)
      ..arcToPoint(Offset(radius, 0),
          radius: Radius.circular(radius), clockwise: false)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
