import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../models/news_article.dart';
import '../../models/comment_store.dart';
import '../../models/bookmark_store.dart';

class NewsDetail extends StatefulWidget {
  final NewsArticle article;

  const NewsDetail({super.key, required this.article});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  final TextEditingController _commentCtrl = TextEditingController();
  double _fontSize = 15;

  void _openComments() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0B0E11),
      builder: (_) {
        final comments = CommentStore.getComments(widget.article.id);

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                const SizedBox(height: 12),
                const Text(
                  'Comments',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const Divider(),

                Expanded(
                  child: ListView(
                    children: comments
                        .map(
                          (c) => ListTile(
                            title: Text(
                              c,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentCtrl,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Write a comment...',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.green),
                        onPressed: () {
                          if (_commentCtrl.text.trim().isNotEmpty) {
                            setState(() {
                              CommentStore.add(
                                widget.article.id,
                                _commentCtrl.text.trim(),
                              );
                              _commentCtrl.clear();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final commentCount = CommentStore.count(widget.article.id);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: const Text('News'), backgroundColor: Colors.black),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.article.image,
              height: 220,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            widget.article.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            '${widget.article.source} • ${widget.article.timeAgo}',
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 16),

          Text(
            widget.article.content,
            style: TextStyle(
              color: Colors.white70,
              fontSize: _fontSize,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 24),

          // 🔥 ACTION BAR — THIS IS WHERE YOUR ROW GOES
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 💬 COMMENTS
              GestureDetector(
                onTap: _openComments,
                child: Column(
                  children: [
                    const Icon(Icons.chat_bubble_outline, color: Colors.grey),
                    Text(
                      '$commentCount',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),

              // 🔗 SHARE
              GestureDetector(
                onTap: () {
                  Share.share(
                    '${widget.article.title}\n\n${widget.article.content}',
                  );
                },
                child: const Icon(Icons.share, color: Colors.grey),
              ),

              // ⭐ BOOKMARK
              GestureDetector(
                onTap: () {
                  setState(() {
                    BookmarkStore.toggle(widget.article.id);
                  });
                },
                child: Icon(
                  BookmarkStore.isBookmarked(widget.article.id)
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: BookmarkStore.isBookmarked(widget.article.id)
                      ? Colors.orange
                      : Colors.grey,
                ),
              ),

              // 🔤 TEXT SIZE
              GestureDetector(
                onTap: () {
                  setState(() {
                    _fontSize = _fontSize == 15
                        ? 18
                        : _fontSize == 18
                        ? 21
                        : 15;
                  });
                },
                child: const Icon(Icons.text_fields, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
