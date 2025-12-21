class News {
  final String title;
  final String url;
  final String source;
  final String publishedAt;

  News({
    required this.title,
    required this.url,
    required this.source,
    required this.publishedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      source: json['source']?['title'] ?? 'Unknown',
      publishedAt: json['published_at'] ?? '',
    );
  }
}
