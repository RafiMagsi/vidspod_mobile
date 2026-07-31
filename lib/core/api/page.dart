/// One page of items plus its cursor/pagination info, per
/// docs/MOBILE_APP_GUIDE.md §3.2.
///
/// Two styles exist and are mirrored (not unified) client-side:
///  - **Keyset** (projects): `data.items[]` + `data.next_cursor`
///    (null = end). Use for infinite scroll.
///  - **Page number** (my-shorts): `data.items[]` + `data.pagination{page,…}`.
class Page<T> {
  final List<T> items;
  final String? nextCursor;
  final int? page;

  const Page({required this.items, this.nextCursor, this.page});

  bool get hasNext => nextCursor != null;
}
