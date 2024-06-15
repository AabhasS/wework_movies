import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pagination_state.dart';

class PaginationCubit<T> extends Cubit<PaginationState<T>> {
  PaginationCubit(this.preloadedItems, this.callback)
      : super(PaginationInitial<T>());

  final List<T> preloadedItems;

  final Future<List<T>> Function(int, int) callback;

  void fetchPaginatedList({ValueGetter<Map<int, T>?>? updateCachedList}) {
    if (state is PaginationInitial) {
      _fetchAndEmitPaginatedList(previousList: preloadedItems);
    } else if (state is PaginationLoaded<T>) {
      final loadedState = state as PaginationLoaded;
      if (loadedState.hasReachedEnd) return;

      /// Update cached entries in loaded state
      if (updateCachedList != null) {
        updateCachedList()?.entries.forEach((element) {
          (loadedState.items as List<T>)[element.key] = element.value;
        });
      }

      _fetchAndEmitPaginatedList(
          previousList: loadedState.items as List<T>,
          pageNumber: loadedState.pageNumber);
    }
  }

  Future<void> refreshPaginatedList({bool resetPage = false}) async {
    emit(PaginationInitial());
    await _fetchAndEmitPaginatedList(
        previousList: preloadedItems, resetPage: resetPage);
  }

  Future<void> _fetchAndEmitPaginatedList({
    List<T>? previousList,
    bool resetPage = false,
    int pageNumber = -1,
  }) async {
    previousList = previousList ?? [];
    try {
      pageNumber++;
      List<T> newList =
          await callback(_getAbsoluteOffset(previousList.length), pageNumber);
      emit(PaginationLoaded(
        items: List<T>.from(previousList + newList),
        hasReachedEnd: newList.isEmpty,
        pageNumber: pageNumber,
      ));
    } on Exception catch (error) {
      emit(PaginationError(error: error));
    }
  }

  int _getAbsoluteOffset(int offset) => offset - preloadedItems.length;
}
