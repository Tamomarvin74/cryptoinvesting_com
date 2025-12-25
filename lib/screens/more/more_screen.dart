import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/theme_viewmodel.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const Text('More'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.settings),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const _TopGrid(),
          const SizedBox(height: 20),

          /// TRACK
          _Section(
            title: 'Track',
            items: const [
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
            items: const [
              _MoreItem(Icons.currency_bitcoin, 'Cryptocurrency'),
              _MoreItem(Icons.show_chart, 'Trending Stocks'),
              _MoreItem(Icons.access_time, 'Pre Market'),
              _MoreItem(Icons.analytics_outlined, 'Analysis & Opinion'),
            ],
          ),

          const SizedBox(height: 20),
          const _Divider(),

          /// TOOLS
          _Section(
            title: 'Tools',
            items: const [
              _MoreItem(Icons.calculate_outlined, 'Currency Converter'),
              _MoreItem(Icons.tune, 'Stock Screener'),
              _MoreItem(Icons.video_call_outlined, 'Webinars'),
              _MoreItem(Icons.percent, 'Fed Rate Monitor'),
            ],
          ),

          const _Divider(),

          /// MORE
          _Section(
            title: 'More',
            items: const [
              _MoreItem(Icons.new_releases_outlined, "What's New"),
              _MoreItem(Icons.help_outline, 'Help Center'),
              _MoreItem(Icons.feedback_outlined, 'Send Feedback'),
            ],
          ),

          /// 🌙 DARK MODE TOGGLE
          const SizedBox(height: 8),
          _ThemeToggleTile(),

          const SizedBox(height: 8),

          _Section(
            title: '',
            items: const [
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

/* -------------------- TOP GRID -------------------- */

class _TopGrid extends StatelessWidget {
  const _TopGrid();

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
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            const Spacer(),
            Text(title, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

/* -------------------- SECTION -------------------- */

class _Section extends StatelessWidget {
  final String title;
  final List<_MoreItem> items;

  const _Section({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
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
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(children: items),
        ),
      ],
    );
  }
}

/* -------------------- MORE ITEM -------------------- */

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
            Icon(icon, color: isRed ? Colors.red : null),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isRed ? Colors.red : null,
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

/* -------------------- THEME TOGGLE -------------------- */

class _ThemeToggleTile extends StatelessWidget {
  const _ThemeToggleTile();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(
      builder: (context, themeVM, _) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Icon(themeVM.isDark ? Icons.dark_mode : Icons.light_mode),
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: themeVM.isDark,
              onChanged: (_) => themeVM.toggleTheme(),
            ),
          ),
        );
      },
    );
  }
}

/* -------------------- DIVIDER -------------------- */

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Divider(thickness: 1, height: 1),
    );
  }
}

/* -------------------- BLANK PAGE -------------------- */

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
      appBar: AppBar(title: Text(title)),
      body: const Center(
        child: Text(
          'Coming Soon',
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      ),
    );
  }
}
