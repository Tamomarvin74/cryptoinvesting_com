class BookmarkStore {
  static final Set<String> _bookmarks = {};

  static void toggle(String id) {
    if (_bookmarks.contains(id)) {
      _bookmarks.remove(id);
    } else {
      _bookmarks.add(id);
    }
  }

  static bool isBookmarked(String id) {
    return _bookmarks.contains(id);
  }
}
