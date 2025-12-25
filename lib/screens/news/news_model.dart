class NewsArticle {
  final String id;
  final String title;
  final String body;
  final String image;
  final String source;
  final String url;
  final String publishedAt;

  NewsArticle({
    required this.id,
    required this.title,
    required this.body,
    required this.image,
    required this.source,
    required this.url,
    required this.publishedAt,
  });

  factory NewsArticle.fromCryptoPanic(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      body: json['body'] ?? json['title'] ?? '',
      image:
          json['thumbnail'] ??
          'https://images.unsplash.com/photo-1621761191319-c6fb62004040',
      source: json['source']['title'] ?? 'Crypto News',
      url: json['url'] ?? '',
      publishedAt: json['published_at'] ?? '',
    );
  }
}
