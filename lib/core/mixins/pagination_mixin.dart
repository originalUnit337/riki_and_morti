mixin PaginationMixin<T> {
  int page = 1;
  bool hasNext = true;
  bool isLoading = false;

  final List<T> items = [];

  void resetPagination() {
    page = 1;
    hasNext = true;
    isLoading = false;
    items.clear();
  }

  bool get canLoadNext => !isLoading && hasNext;
}
