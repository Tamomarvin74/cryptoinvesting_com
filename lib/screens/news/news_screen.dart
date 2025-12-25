import 'package:flutter/material.dart';
import '../../models/news_article.dart';
import '../../services/news_service.dart';
import 'news_detail.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<NewsArticle>> _future;
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _future = NewsService().fetchCryptoNews();
  }

  void _loadNews({String query = ''}) {
    setState(() {
      _future = NewsService().fetchCryptoNews(query: query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        title: const Text('News'),
        backgroundColor: Colors.black,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Featured'),
            Tab(text: 'Breaking'),
            Tab(text: 'Most Popular'),
            Tab(text: 'Cryptocurrency'),
          ],
        ),
      ),
      body: Column(
        children: [
          _searchBar(),
          _proBanner(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(4, (_) => _newsList()),
            ),
          ),
        ],
      ),
    );
  }

  // 🔍 SEARCH BAR
  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: _searchCtrl,
        onSubmitted: (value) => _loadNews(query: value),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search news, forex, crypto, charts...',
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: const Color(0xFF1C1F26),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // 💎 PRO BANNER (Investing-style)
  Widget _proBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0052FF), Color(0xFFFF9800)],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        children: [
          Text(
            'Get 60% Off',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Icon(Icons.star, color: Colors.white),
        ],
      ),
    );
  }

  // 📰 NEWS LIST (Investing-style)
  Widget _newsList() {
    return RefreshIndicator(
      onRefresh: () async {
        _loadNews(query: _searchCtrl.text);
      },
      child: FutureBuilder<List<NewsArticle>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snap.hasError) {
            return Center(
              child: Text(
                snap.error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final news = snap.data ?? [];

          return ListView.builder(
            itemCount: news.length,
            itemBuilder: (_, i) {
              final n = news[i];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    n.image,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  n.title,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  n.source,
                  style: const TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => NewsDetail(article: n)),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
