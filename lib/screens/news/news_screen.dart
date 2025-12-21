import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        title: const Text('News'),
      ),
      body: const Center(
        child: Text(
          'News – Coming Soon',
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      ),
    );
  }
}
