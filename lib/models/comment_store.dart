class CommentStore {
  static final Map<String, List<String>> _comments = {};

  // ➕ Add comment
  static void add(String articleId, String comment) {
    _comments.putIfAbsent(articleId, () => []);
    _comments[articleId]!.add(comment);
  }

  // 📋 Get all comments
  static List<String> getComments(String articleId) {
    return _comments[articleId] ?? [];
  }

  // 🔢 Count comments
  static int count(String articleId) {
    return _comments[articleId]?.length ?? 0;
  }
}
