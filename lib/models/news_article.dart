class NewsArticle {
  final String title;
  final String description;
  final String image;
  final String source;
  final String url;
  int comments;

  NewsArticle({
    required this.title,
    required this.description,
    required this.image,
    required this.source,
    required this.url,
    this.comments = 0,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image:
          json['urlToImage'] ??
          'https://via.placeholder.com/300x200.png?text=News',
      source: json['source']?['name'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
