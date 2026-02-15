class PagedResult<T> {
  final List<T> items;
  final bool hasNext;

  PagedResult({required this.items, required this.hasNext});
}
