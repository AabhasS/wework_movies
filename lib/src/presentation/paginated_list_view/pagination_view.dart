import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/pagination_bloc.dart';

typedef PaginationBuilder<T> = Future<List<T>> Function(
    int currentListSize, int currectPageNo);

enum PaginationViewType { listView, gridView }

class PaginationView<T> extends StatefulWidget {
  PaginationView({
    Key? key,
    required this.itemBuilder,
    required this.pageFetch,
    required this.onEmpty,
    required this.onError,
    this.pullToRefresh = false,
    this.refreshIndicatorColor = Colors.black,
    this.gridDelegate =
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    List<T>? preloadedItems,
    this.initialLoader = const CircularProgressIndicator(),
    this.bottomLoader = const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(),),
    this.scrollDirection = Axis.vertical,
    this.padding = const EdgeInsets.all(0),
    this.separatorBuilder,
    this.scrollController,
    this.updateCachedList,
  })  : preloadedItems = preloadedItems ?? <T>[],
        super(key: key);

  final Widget bottomLoader;
  final SliverGridDelegate gridDelegate;
  final Widget initialLoader;
  final Widget onEmpty;
  final EdgeInsets padding;
  final PaginationBuilder<T> pageFetch;
  final List<T> preloadedItems;
  final bool pullToRefresh;
  final Color refreshIndicatorColor;
  final ScrollController? scrollController;
  final Axis scrollDirection;

  /// List data Updates without refreshing the entire list
  final ValueGetter<Map<int, T>?>? updateCachedList;

  @override
  PaginationViewState<T> createState() => PaginationViewState<T>();

  final Widget Function(BuildContext, T, int) itemBuilder;

  final Widget Function(BuildContext, int)? separatorBuilder;

  final Widget Function(dynamic) onError;
}

class PaginationViewState<T> extends State<PaginationView<T>> {
  PaginationCubit<T>? _cubit;
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController;
    _cubit = PaginationCubit<T>(widget.preloadedItems, widget.pageFetch)
      ..fetchPaginatedList();
  }

  Future<void> refresh({bool resetPage = false}) async {
    await _cubit!.refreshPaginatedList(resetPage: resetPage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginationCubit<T>, PaginationState<T>>(
      bloc: _cubit,
      builder: (context, state) {
        if (state is PaginationInitial<T>) {
          return widget.initialLoader;
        } else if (state is PaginationError<T>) {
          if (widget.pullToRefresh) {
            return RefreshIndicator(
              color: widget.refreshIndicatorColor,
              onRefresh: () => refresh(resetPage: true),
              child: _buildSingleWidgetView(widget.onError(state.error)),
            );
          } else {
            return widget.onError(state.error);
          }
        } else {
          final loadedState = state as PaginationLoaded<T>;
          if (loadedState.items.isEmpty) {
            if (widget.pullToRefresh) {
              return RefreshIndicator(
                color: widget.refreshIndicatorColor,
                onRefresh: () => refresh(resetPage: true),
                child: _buildSingleWidgetView(widget.onEmpty),
              );
            } else {
              return widget.onEmpty;
            }
          }
          if (widget.pullToRefresh) {
            return RefreshIndicator(
              color: widget.refreshIndicatorColor,
              onRefresh: () => refresh(resetPage: true),
              child: _buildCustomScrollView(loadedState: loadedState),
            );
          }
          return _buildCustomScrollView(loadedState: loadedState);
        }
      },
    );
  }

  _buildSingleWidgetView(Widget widget) {
    return Stack(
      children: <Widget>[
        ListView(),
        widget,
      ],
    );
  }

  _buildCustomScrollView(
      {PaginationLoaded<T>? loadedState, bool showShimmer = false}) {
    return CustomScrollView(
      controller: _scrollController,
      scrollDirection: widget.scrollDirection,
      slivers: [
        SliverPadding(
          padding: widget.padding,
          sliver: loadedState != null && !showShimmer
              ? _buildSliverList(loadedState)
              : _buildSliverShimmer(),
        ),
      ],
    );
  }

  _buildSliverShimmer() {
    return SliverList(
      delegate: SliverChildListDelegate([
        widget.initialLoader,
      ]),
    );
  }

  _buildSliverList(PaginationLoaded<T> loadedState) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final itemIndex = index ~/ 2;
          if (index.isEven) {
            if (itemIndex >= loadedState.items.length) {
              _cubit!.fetchPaginatedList(
                  updateCachedList: widget.updateCachedList);
              return widget.bottomLoader;
            }
            return widget.itemBuilder(
                context, loadedState.items[itemIndex], itemIndex);
          }
          return widget.separatorBuilder != null
              ? widget.separatorBuilder!(context, itemIndex)
              : const SizedBox();
        },
        semanticIndexCallback: (widget, localIndex) {
          if (localIndex.isEven) {
            return localIndex ~/ 2;
          }
          // ignore: avoid_returning_null
          return null;
        },
        childCount: max(
            0,
            (loadedState.hasReachedEnd
                        ? loadedState.items.length
                        : loadedState.items.length + 1) *
                    2 -
                1),
      ),
    );
  }
}
