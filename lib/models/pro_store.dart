class ProStore {
  static bool isPro = false;

  static final Set<String> _unlockedArticles = {};

  static bool isArticleUnlocked(String id) {
    return _unlockedArticles.contains(id);
  }

  static void unlockArticle(String id) {
    _unlockedArticles.add(id);
  }
}
