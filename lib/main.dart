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
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0C0910),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFB46CFF),
          secondary: Color(0xFFC9C4D2),
          surface: Color(0xFF17121C),
          outline: Color(0xFF9C94A6),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xE617121C),
          elevation: 8,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFF8D8298)),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0C0910),
          foregroundColor: Color(0xFFF2EDF7),
          surfaceTintColor: Colors.transparent,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF6F2D91),
            foregroundColor: Colors.white,
          ),
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
            const Text('Welcome, Kat', style: TextStyle(fontSize: 18, color: Color(0xFFC9C4D2))),
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
    Color(0xFF2A173D),
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

class TablePreviewScreen extends StatefulWidget {
  const TablePreviewScreen({super.key});

  @override
  State<TablePreviewScreen> createState() => _TablePreviewScreenState();
}

class _TablePreviewScreenState extends State<TablePreviewScreen> {
  double cardScale = 1.0;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('ENDRA CANASTA', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.1)),
      actions: const [
        _TableTopAction(Icons.person_rounded, 'Profile'),
        _TableTopAction(Icons.groups_rounded, 'Players'),
        _TableTopAction(Icons.chat_bubble_rounded, 'Messages'),
        _TableTopAction(Icons.emoji_events_rounded, 'Stats'),
      ],
    ),
    body: SafeArea(
      child: LayoutBuilder(builder: (context, box) {
        final compact = box.maxWidth < 600;
        final hand = ['2♠','3♠','4♠','5♥','6♥','7♥','8♥','9♥','10♥','J♣','Q♣','K♣','A♦'];
        final baseCardWidth = ((box.maxWidth - (compact ? 20 : 52)) / hand.length).clamp(36.0, 76.0);
        final handCardWidth = baseCardWidth * cardScale;
        final handCardHeight = handCardWidth * 1.42;
        final meldCardWidth = (box.maxWidth * (compact ? .105 : .075)).clamp(38.0, 66.0);
        final sideWidth = compact ? 54.0 : 92.0;

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              radius: 1.2,
              colors: [Color(0xFF21102E), Color(0xFF08070A), Color(0xFF020203)],
            ),
          ),
          child: Stack(children: [
            const Positioned.fill(child: IgnorePointer(child: _HydraTableFrame())),
            Column(children: [
              Padding(
                padding: EdgeInsets.fromLTRB(compact ? 8 : 18, 8, compact ? 8 : 18, 2),
                child: const Row(children: [
                  Expanded(child: _GameBadge('CASUAL CANASTA', '4 PLAYERS · FIRST TO 5,000')),
                ]),
              ),
              Expanded(
                child: Row(children: [
                  SizedBox(width: sideWidth, child: const _EdgeSeat(name: 'Mike', score: '2,150')),
                  Expanded(
                    child: Column(children: [
                      const SizedBox(height: 4),
                      const _OpponentHand(),
                      const SizedBox(height: 4),
                      const _SeatBadge(name: 'Sarah', detail: 'Partner · 9 cards'),
                      const Spacer(),
                      const _MeldRow(
                        groups: [
                          ['8♠','8♥','8♣','8♦'],
                          ['5♠','5♥','5♣','5♦'],
                          ['K♠','K♥','K♣','K♦'],
                        ],
                      ),
                      const Spacer(),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _PileCard(back: true, label: 'DRAW', count: '38'),
                          SizedBox(width: 18),
                          _PileCard(back: false, label: 'DISCARD', count: '7', face: 'Q♥'),
                        ],
                      ),
                      const Spacer(),
                      const _MeldRow(
                        groups: [
                          ['10♠','10♥','10♣','10♦'],
                          ['J♠','J♥','J♣','J♦'],
                          ['9♠','9♥','9♣','9♦'],
                        ],
                      ),
                      const Spacer(),
                      const _SeatBadge(name: 'Kat', detail: 'Your turn · 3,120'),
                      const SizedBox(height: 4),
                    ]),
                  ),
                  SizedBox(width: sideWidth, child: const _EdgeSeat(name: 'Jordan', score: '2,150')),
                ]),
              ),
              SizedBox(
                height: handCardHeight + 8,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(children: [
                    for (final card in hand)
                      _PlayingCard(card, width: handCardWidth, height: handCardHeight),
                  ]),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(compact ? 8 : 16, 8, compact ? 8 : 16, 10),
                decoration: const BoxDecoration(
                  color: Color(0xE608050B),
                  border: Border(top: BorderSide(color: Color(0xFF7E32B5))),
                ),
                child: Row(children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Type a message to the table…',
                        prefixIcon: const Icon(Icons.chat_bubble_rounded),
                        suffixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.send_rounded)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text('Card Size', style: TextStyle(fontWeight: FontWeight.w700)),
                  IconButton(
                    tooltip: 'Smaller cards',
                    onPressed: cardScale <= .78 ? null : () => setState(() => cardScale = (cardScale - .1).clamp(.75, 1.35)),
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  SizedBox(
                    width: compact ? 76 : 130,
                    child: Slider(
                      value: cardScale,
                      min: .75,
                      max: 1.35,
                      divisions: 6,
                      onChanged: (value) => setState(() => cardScale = value),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Larger cards',
                    onPressed: cardScale >= 1.32 ? null : () => setState(() => cardScale = (cardScale + .1).clamp(.75, 1.35)),
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ]),
              ),
            ]),
          ]),
        );
      }),
    ),
  );
}

class _TableTopAction extends StatelessWidget {
  final IconData icon;
  final String label;
  const _TableTopAction(this.icon, this.label);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 3),
    child: Tooltip(message: label, child: Icon(icon, size: 22)),
  );
}

class _GameBadge extends StatelessWidget {
  final String title;
  final String detail;
  const _GameBadge(this.title, this.detail);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: const Color(0xCC100A15),
      border: Border.all(color: const Color(0xFF7E32B5)),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
      const SizedBox(width: 10),
      Flexible(child: Text(detail, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, color: Color(0xFFC9C4D2)))),
    ]),
  );
}

class _HydraTableFrame extends StatelessWidget {
  const _HydraTableFrame();

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFF6F2D91), width: 3),
      boxShadow: const [
        BoxShadow(color: Color(0x887E32B5), blurRadius: 28, spreadRadius: 2),
        BoxShadow(color: Color(0x557A5415), blurRadius: 12, spreadRadius: 1),
      ],
    ),
    child: const Center(
      child: Opacity(
        opacity: .07,
        child: Icon(Icons.local_fire_department_rounded, size: 260, color: Color(0xFFB46CFF)),
      ),
    ),
  );
}

class _OpponentHand extends StatelessWidget {
  const _OpponentHand();

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 52,
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      for (var i = 0; i < 10; i++)
        Transform.translate(offset: Offset(i == 0 ? 0 : -i * 3.0, 0), child: const _CardBack(width: 34, height: 48)),
    ]),
  );
}

class _CardBack extends StatelessWidget {
  final double width;
  final double height;
  const _CardBack({required this.width, required this.height});

  @override
  Widget build(BuildContext context) => Container(
    width: width,
    height: height,
    margin: const EdgeInsets.symmetric(horizontal: 1),
    decoration: BoxDecoration(
      gradient: const RadialGradient(colors: [Color(0xFFB46CFF), Color(0xFF4D176B), Color(0xFF100A15)]),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: const Color(0xFFE7D8F2), width: 1.2),
      boxShadow: const [BoxShadow(color: Color(0x667E32B5), blurRadius: 7)],
    ),
    child: const Icon(Icons.local_fire_department_rounded, color: Color(0xFFE1B7FF), size: 20),
  );
}

class _SeatBadge extends StatelessWidget {
  final String name;
  final String detail;
  const _SeatBadge({required this.name, required this.detail});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: const Color(0xE6100A15),
      border: Border.all(color: const Color(0xFF8E5B24)),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      const CircleAvatar(radius: 11, backgroundColor: Color(0xFF6F2D91), child: Icon(Icons.person, size: 14)),
      const SizedBox(width: 6),
      Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(width: 6),
      Text(detail, style: const TextStyle(fontSize: 10, color: Color(0xFFC9C4D2))),
    ]),
  );
}

class _EdgeSeat extends StatelessWidget {
  final String name;
  final String score;
  const _EdgeSeat({required this.name, required this.score});

  @override
  Widget build(BuildContext context) => Center(
    child: RotatedBox(
      quarterTurns: name == 'Mike' ? 1 : 3,
      child: _SeatBadge(name: name, detail: score),
    ),
  );
}

class _MeldRow extends StatelessWidget {
  final List<List<String>> groups;
  const _MeldRow({required this.groups});

  @override
  Widget build(BuildContext context) => FittedBox(
    fit: BoxFit.scaleDown,
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      for (final group in groups) ...[
        _VerticalMeld(cards: group),
        const SizedBox(width: 14),
      ],
    ]),
  );
}

class _VerticalMeld extends StatelessWidget {
  final List<String> cards;
  const _VerticalMeld({required this.cards});

  @override
  Widget build(BuildContext context) {
    const width = 52.0;
    const height = 74.0;
    const overlap = 20.0;
    return SizedBox(
      width: width,
      height: height + overlap * (cards.length - 1),
      child: Stack(children: [
        for (var i = 0; i < cards.length; i++)
          Positioned(top: i * overlap, child: _PlayingCard(cards[i], width: width, height: height)),
      ]),
    );
  }
}

class _PileCard extends StatelessWidget {
  final bool back;
  final String label;
  final String count;
  final String face;
  const _PileCard({required this.back, required this.label, required this.count, this.face = ''});

  @override
  Widget build(BuildContext context) => Column(children: [
    if (back)
      const _CardBack(width: 54, height: 76)
    else
      _PlayingCard(face, width: 54, height: 76),
    const SizedBox(height: 3),
    Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
    Text(count, style: const TextStyle(fontSize: 10, color: Color(0xFFC9C4D2))),
  ]);
}

class _ScoreCard extends StatelessWidget {
  final String title,names,score; const _ScoreCard(this.title,this.names,this.score);
  @override Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.symmetric(vertical:10,horizontal:8), child: Column(children:[Text(title,style:const TextStyle(fontSize:11,fontWeight:FontWeight.bold,color:Color(0xFFC9C4D2))),Text(names),Text(score,style:const TextStyle(fontSize:24,fontWeight:FontWeight.bold,color:Color(0xFFB46CFF)))])));
}

class _PlayerSeat extends StatelessWidget {
  final String name,detail; final bool active; final VoidCallback onTap;
  const _PlayerSeat({required this.name,required this.detail,required this.active,required this.onTap});
  @override Widget build(BuildContext context) => InkWell(onTap:onTap,borderRadius:BorderRadius.circular(16),child:Container(
    constraints: const BoxConstraints(minWidth:92), padding:const EdgeInsets.all(10),
    decoration:BoxDecoration(color:const Color(0xCC17121C),border:Border.all(width:active?2:1,color:active?const Color(0xFFB46CFF):const Color(0xFF8D8298)),borderRadius:BorderRadius.circular(16),boxShadow:active?[const BoxShadow(color:Color(0x557E32B5),blurRadius:14)]:null),
    child:Column(children:[const CircleAvatar(radius:25,backgroundColor:Color(0xFF6F2D91),child:Icon(Icons.person,size:30)),const SizedBox(height:4),Text(name,style:const TextStyle(fontWeight:FontWeight.bold,fontSize:16)),Text(detail,style:const TextStyle(fontSize:11))])));
}

class _PlayingCard extends StatelessWidget {
  final String label; final double width,height; const _PlayingCard(this.label,{required this.width,required this.height});
  @override Widget build(BuildContext context) { final red=label.contains('♥')||label.contains('♦'); return Container(
    width:width,height:height,margin:const EdgeInsets.symmetric(horizontal:2),padding:const EdgeInsets.all(7),
    decoration:BoxDecoration(gradient:const LinearGradient(colors:[Color(0xFF211829),Color(0xFF0E0B11)]),borderRadius:BorderRadius.circular(10),border:Border.all(color:const Color(0xFFC9C4D2),width:1.4),boxShadow:const [BoxShadow(color:Color(0x443C1458),blurRadius:8)]),
    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(label,style:TextStyle(fontSize:width>80?26:20,fontWeight:FontWeight.w900,color:red?const Color(0xFFCF77FF):const Color(0xFFF2EDF7))),const Spacer(),Align(alignment:Alignment.bottomRight,child:Text(label.substring(label.length-1),style:TextStyle(fontSize:width>80?34:25,color:red?const Color(0xFFCF77FF):const Color(0xFFC9C4D2))))]));
  }
}
