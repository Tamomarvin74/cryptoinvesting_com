import 'package:flutter/material.dart';
import '../../models/pro_store.dart';
import 'ad_campaign_screen.dart';

class ProPaywallScreen extends StatelessWidget {
  final String articleId;

  const ProPaywallScreen({super.key, required this.articleId});

  Future<void> _startAd(BuildContext context) async {
    final unlocked = await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => AdCampaignScreen(articleId: articleId),
      ),
    );

    if (unlocked == true) {
      ProStore.unlockArticle(articleId);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Cryptoinvesting Pro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, color: Colors.orange, size: 60),
            const SizedBox(height: 20),

            const Text(
              'Unlock This Article',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            const Text(
              'Watch a short sponsored video to unlock this premium article.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => _startAd(context),
                child: const Text(
                  'Unlock This Article',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}
