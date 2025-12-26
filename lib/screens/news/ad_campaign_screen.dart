import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AdCampaignScreen extends StatefulWidget {
  final String articleId;

  const AdCampaignScreen({super.key, required this.articleId});

  @override
  State<AdCampaignScreen> createState() => _AdCampaignScreenState();
}

class _AdCampaignScreenState extends State<AdCampaignScreen> {
  late VideoPlayerController _controller;
  bool _isReady = false;
  bool _canContinue = false;
  int _remaining = 30; // ⏱️ seconds to watch

  @override
  void initState() {
    super.initState();

    _controller =
        VideoPlayerController.network(
            // ✅ Reliable crypto-style sample video (works on iOS & Android)
            'https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
          )
          ..initialize().then((_) {
            if (!mounted) return;
            setState(() {
              _isReady = true;
            });
            _controller.play();
            _startCountdown();
          });
  }

  void _startCountdown() async {
    while (_remaining > 0 && mounted) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _remaining--;
      });
    }

    if (mounted) {
      setState(() {
        _canContinue = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            const Text(
              'Sponsored Video',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            // 🎥 VIDEO OR LOADER
            _isReady
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : const CircularProgressIndicator(
                    color: Colors.orange, // ✅ same spinner color
                  ),

            const Spacer(),

            Text(
              _canContinue
                  ? 'Ad completed'
                  : 'Watch full ad to unlock this article',
              style: const TextStyle(color: Colors.white),
            ),

            const SizedBox(height: 6),

            if (!_canContinue)
              Text(
                '$_remaining seconds remaining',
                style: const TextStyle(color: Colors.grey),
              ),

            const SizedBox(height: 16),

            // 🔓 CONTINUE BUTTON (LOCKED UNTIL AD COMPLETES)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _canContinue
                      ? Colors.orange
                      : Colors.grey.shade800,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: _canContinue
                    ? () => Navigator.pop(context, true)
                    : null,
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
