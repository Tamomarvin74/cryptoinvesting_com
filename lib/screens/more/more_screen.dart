import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        title: const Text('More'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _TopGrid(),
          const SizedBox(height: 20),

          /// TRACK
          _Section(
            title: 'Track',
            items: [
              _MoreItem(Icons.notifications_none, 'Alerts'),
              _MoreItem(Icons.bookmark_border, 'Saved Items'),
              _MoreItem(Icons.trending_up, 'My Sentiments'),
              _MoreItem(Icons.block, 'Ad-Free Version', isRed: true),
            ],
          ),

          const SizedBox(height: 20),

          /// LIVE MARKETS
          _Section(
            title: 'Live Markets',
            items: [
              _MoreItem(Icons.currency_bitcoin, 'Cryptocurrency'),
              _MoreItem(Icons.show_chart, 'Trending Stocks'),
              _MoreItem(Icons.access_time, 'Pre Market'),
              _MoreItem(Icons.analytics_outlined, 'Analysis & Opinion'),
            ],
          ),

          const SizedBox(height: 20),
          _Divider(),

          /// TOOLS
          _Section(
            title: 'Tools',
            items: [
              _MoreItem(Icons.calculate_outlined, 'Currency Converter'),
              _MoreItem(Icons.tune, 'Stock Screener'),
              _MoreItem(Icons.video_call_outlined, 'Webinars'),
              _MoreItem(Icons.percent, 'Fed Rate Monitor'),
            ],
          ),

          _Divider(),

          /// MORE
          _Section(
            title: 'More',
            items: [
              _MoreItem(Icons.new_releases_outlined, "What's New"),
              _MoreItem(Icons.help_outline, 'Help Center'),
              _MoreItem(Icons.feedback_outlined, 'Send Feedback'),
              _MoreItem(
                Icons.notifications_outlined,
                'Push Notification Settings',
              ),
              _MoreItem(Icons.settings_outlined, 'Settings'),
              _MoreItem(Icons.person_add_alt_1_outlined, 'Invite Friends'),
              _MoreItem(Icons.gavel_outlined, 'Legal'),
              _MoreItem(Icons.logout, 'Sign Out', isRed: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _TopGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: const [
        _GridItem(Icons.calendar_month, 'Calendars'),
        _GridItem(Icons.smart_toy_outlined, 'WarrenAI'),
        _GridItem(Icons.people_outline, 'Find Top Brokers'),
        _GridItem(Icons.flag_outlined, 'Investing Challenges'),
      ],
    );
  }
}

class _GridItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _GridItem(this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openBlank(context, title),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E222D),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<_MoreItem> items;

  const _Section({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 4, 4, 8),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E222D),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(children: items),
        ),
      ],
    );
  }
}

class _MoreItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isRed;

  const _MoreItem(this.icon, this.title, {this.isRed = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openBlank(context, title),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFF2A2E39))),
        ),
        child: Row(
          children: [
            Icon(icon, color: isRed ? Colors.red : Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isRed ? Colors.red : Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Divider(color: Color(0xFF1E222D), thickness: 1, height: 1),
    );
  }
}

void _openBlank(BuildContext context, String title) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => _BlankPage(title: title)),
  );
}

class _BlankPage extends StatelessWidget {
  final String title;
  const _BlankPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        title: Text(title),
      ),
      body: const Center(
        child: Text(
          'Coming Soon',
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      ),
    );
  }
}
