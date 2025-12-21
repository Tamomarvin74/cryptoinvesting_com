class News {
  final String title;
  final String source;
  final String publishedAt;

  News({required this.title, required this.source, required this.publishedAt});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? '',
      source: json['source']?['title'] ?? '',
      publishedAt: json['published_at'] ?? '',
    );
  }
}
