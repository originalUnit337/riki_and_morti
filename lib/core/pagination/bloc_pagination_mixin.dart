import 'package:riki_and_morti/core/pagination/paged_result.dart';

mixin BlocPaginationMixin<T> {
  int page = 0;
  bool hasNext = true;
  bool isLoading = false;
  final List<T> items = [];

  bool get canLoadNext => hasNext && !isLoading;

  void resetPagination() {
    page = 0;
    hasNext = true;
    isLoading = false;
    items.clear();
  }

  Future<void> loadFirstPage({
    required Future<PagedResult<T>> Function(int page) fetchData,
    required T Function(T item, Set<int> favourites) updateItem,
  }) async {
    resetPagination();
    await _loadPage(fetchData, updateItem);
  }

  Future<void> loadNextPage({
    required Future<PagedResult<T>> Function(int page) fetchData,
    required T Function(T item, Set<int> favourites) updateItem,
  }) async {
    if (!canLoadNext) return;

    isLoading = true;
    await _loadPage(fetchData, updateItem);
    isLoading = false;
  }

  Future<void> _loadPage(
    Future<PagedResult<T>> Function(int page) fetchData,
    T Function(T item, Set<int> favourites) updateItem,
  ) async {
    final result = await fetchData(++page);
    hasNext = result.hasNext;
    
    final favouriteIds = _favouriteIdsCallback?.call() ?? <int>{};
    final updatedItems = result.items.map((item) => 
      updateItem(item, favouriteIds)
    );
    items.addAll(updatedItems);
  }

  Set<int> Function()? _favouriteIdsCallback;

  void setFavouriteIdsCallback(Set<int> Function() callback) {
    _favouriteIdsCallback = callback;
  }
}
