class NewsArticle {
  final String id;
  final String title;
  final String image;
  final String source;
  final DateTime publishedAt;
  final String content;

  NewsArticle({
    required this.id,
    required this.title,
    required this.image,
    required this.source,
    required this.publishedAt,
    required this.content,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['url'] ?? DateTime.now().toIso8601String(),
      title: json['title'] ?? '',
      image:
          json['urlToImage'] ??
          'https://via.placeholder.com/400x200.png?text=No+Image',
      source: json['source']?['name'] ?? 'Unknown',
      publishedAt:
          DateTime.tryParse(json['publishedAt'] ?? '') ?? DateTime.now(),
      content: json['content'] ?? '',
    );
  }

  String get timeAgo {
    final diff = DateTime.now().difference(publishedAt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
