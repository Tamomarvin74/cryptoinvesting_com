import 'package:flutter/material.dart';
import '../../models/news_article.dart';
import '../../models/comment.dart';

class NewsDetail extends StatefulWidget {
  final NewsArticle article;
  const NewsDetail({super.key, required this.article});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  final List<Comment> _comments = [];
  final TextEditingController _ctrl = TextEditingController();

  void _addComment() {
    if (_ctrl.text.isEmpty) return;
    setState(() {
      _comments.add(Comment(_ctrl.text, DateTime.now()));
      widget.article.comments++;
      _ctrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(widget.article.source)),
      body: Column(
        children: [
          Image.network(widget.article.image),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              widget.article.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: _comments
                  .map(
                    (c) => ListTile(
                      title: Text(
                        c.text,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        c.time.toLocal().toString(),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          _commentBox(),
        ],
      ),
    );
  }

  Widget _commentBox() {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _ctrl,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Write a comment...',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: _addComment,
          ),
        ],
      ),
    );
  }
}
