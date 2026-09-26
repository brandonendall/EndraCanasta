import 'package:flutter/material.dart';
import 'prototype_screens.dart';

void main() => runApp(const EndraCanastaApp());

class EndraCanastaApp extends StatelessWidget {
  const EndraCanastaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Endra Canasta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF76538F),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final destinations = <({IconData icon, String title, String subtitle})>[
      (icon: Icons.school_rounded, title: 'Learn & Practice', subtitle: 'Learn from the beginning or sharpen your game'),
      (icon: Icons.style_rounded, title: 'Solo Play', subtitle: 'Play at your pace with computer-controlled seats'),
      (icon: Icons.sentiment_satisfied_alt_rounded, title: 'Casual Play', subtitle: 'Relaxed games with real players'),
      (icon: Icons.emoji_events_rounded, title: 'Competitive Play', subtitle: 'Skill-based matches and divisions'),
      (icon: Icons.groups_rounded, title: 'Friends & Private Tables', subtitle: 'Invite friends, team up, or host a table'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('ENDRA CANASTA', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.2)),
        actions: [
          IconButton(
            tooltip: 'Customize',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomizeScreen())),
            icon: const Icon(Icons.palette_rounded),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.account_circle_rounded)),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const Text('Welcome back', style: TextStyle(fontSize: 15)),
            const Text('What would you like to play?', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 18),
            for (final item in destinations)
              Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  minVerticalPadding: 18,
                  leading: CircleAvatar(child: Icon(item.icon)),
                  title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: Text(item.subtitle),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    final Widget screen = switch (item.title) {
                      'Learn & Practice' => const LearnScreen(),
                      'Competitive Play' => const CompetitiveScreen(),
                      'Friends & Private Tables' => const FriendsScreen(),
                      'Casual Play' => const TablePreviewScreen(),
                      'Solo Play' => const TablePreviewScreen(),
                      _ => const TablePreviewScreen(),
                    };
                    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
                  },
                ),
              ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavShortcut(Icons.people_rounded, 'Friends'),
                _NavShortcut(Icons.chat_bubble_rounded, 'Messages'),
                _NavShortcut(Icons.bar_chart_rounded, 'Stats'),
                _NavShortcut(Icons.person_rounded, 'Profile'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NavShortcut extends StatelessWidget {
  final IconData icon;
  final String label;
  const _NavShortcut(this.icon, this.label);

  @override
  Widget build(BuildContext context) => Column(
    children: [Icon(icon), const SizedBox(height: 4), Text(label, style: const TextStyle(fontSize: 12))],
  );
}

class CustomizeScreen extends StatefulWidget {
  const CustomizeScreen({super.key});

  @override
  State<CustomizeScreen> createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {
  int selected = 0;
  final tableColors = const [
    Color(0xFF285B4A),
    Color(0xFF263D68),
    Color(0xFF5C2947),
    Color(0xFF493264),
    Color(0xFF202124),
    Color(0xFF176466),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Make It Yours')),
    body: ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text('My Table', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const Text('Your choices change your view—not anyone else’s game.'),
        const SizedBox(height: 16),
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 210,
          decoration: BoxDecoration(color: tableColors[selected], borderRadius: BorderRadius.circular(24)),
          child: const Center(child: Text('LIVE TABLE PREVIEW', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1))),
        ),
        const SizedBox(height: 18),
        const Text('Table color', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          children: List.generate(tableColors.length, (i) => GestureDetector(
            onTap: () => setState(() => selected = i),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: tableColors[i],
              child: selected == i ? const Icon(Icons.check_rounded) : null,
            ),
          )),
        ),
        const SizedBox(height: 24),
        const ListTile(leading: Icon(Icons.style_rounded), title: Text('Card Faces'), subtitle: Text('Classic · Modern · Large Print · Minimal · Elegant')),
        const ListTile(leading: Icon(Icons.flip_rounded), title: Text('Card Backs'), subtitle: Text('Patterns and designs')),
        const ListTile(leading: Icon(Icons.person_rounded), title: Text('Profile Style'), subtitle: Text('Photo · Banner · Frame · Badge')),
        const ListTile(leading: Icon(Icons.accessibility_new_rounded), title: Text('Accessibility'), subtitle: Text('Larger cards · High contrast · Reduced motion')),
      ],
    ),
  );
}

class TablePreviewScreen extends StatelessWidget {
  const TablePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Casual Game · Hand 3')),
    body: Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF214D40), Color(0xFF12342C)]),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(child: _ScoreCard('YOUR TEAM', 'Kat + Sarah', '2,480')),
                SizedBox(width: 8),
                Expanded(child: _ScoreCard('OPPONENTS', 'Mike + Jordan', '2,150')),
              ],
            ),
            const SizedBox(height: 12),
            const _PlayerSeat(name: 'Sarah', detail: 'Partner · 9 cards', active: false),
            const Spacer(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _PlayerSeat(name: 'Mike', detail: '11 cards', active: true),
                Column(children: [Icon(Icons.layers_rounded, size: 42), Text('Draw 38'), SizedBox(height: 8), Icon(Icons.style_rounded, size: 42), Text('Discard 7')]),
                _PlayerSeat(name: 'Jordan', detail: '8 cards', active: false),
              ],
            ),
            const Spacer(),
            const Text('YOUR HAND', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 88,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _PlayingCard('A♠'), _PlayingCard('A♥'), _PlayingCard('7♣'), _PlayingCard('7♦'),
                  _PlayingCard('J♠'), _PlayingCard('Q♥'), _PlayingCard('2♣'), _PlayingCard('5♦'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.chat_rounded), label: const Text('Chat'))),
                const SizedBox(width: 8),
                Expanded(child: FilledButton.tonalIcon(onPressed: () {}, icon: const Icon(Icons.scoreboard_rounded), label: const Text('Score'))),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class _ScoreCard extends StatelessWidget {
  final String title, names, score;
  const _ScoreCard(this.title, this.names, this.score);
  @override
  Widget build(BuildContext context) => Card(child: Padding(
    padding: const EdgeInsets.all(10),
    child: Column(children: [Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), Text(names), Text(score, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))]),
  ));
}

class _PlayerSeat extends StatelessWidget {
  final String name, detail;
  final bool active;
  const _PlayerSeat({required this.name, required this.detail, required this.active});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(border: Border.all(width: active ? 2 : 1, color: active ? Theme.of(context).colorScheme.primary : Colors.white24), borderRadius: BorderRadius.circular(14)),
    child: Column(children: [const CircleAvatar(child: Icon(Icons.person)), Text(name, style: const TextStyle(fontWeight: FontWeight.bold)), Text(detail, style: const TextStyle(fontSize: 11))]),
  );
}

class _PlayingCard extends StatelessWidget {
  final String label;
  const _PlayingCard(this.label);
  @override
  Widget build(BuildContext context) => Container(
    width: 54,
    margin: const EdgeInsets.only(right: 5),
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: label.contains('♥') || label.contains('♦') ? Colors.red : Colors.black)),
  );
}
