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

class TablePreviewScreen extends StatelessWidget {
  const TablePreviewScreen({super.key});
  void _info(BuildContext c, String title, String body) => showDialog(context: c, builder: (_) => AlertDialog(title: Text(title), content: Text(body), actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text('Close'))]));
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Casual Game · Hand 3')),
    body: SafeArea(child: LayoutBuilder(builder: (context, box) {
      final tablet = box.maxWidth >= 700;
      final cards = ['A♠','A♥','7♣','7♦','J♠','Q♥','2♣','5♦'];
      final cardW = ((box.maxWidth - (tablet ? 64 : 24)) / cards.length).clamp(46.0, tablet ? 104.0 : 72.0);
      final cardH = tablet ? 150.0 : 112.0;
      return Container(
        width: double.infinity, height: double.infinity,
        padding: EdgeInsets.fromLTRB(tablet ? 20 : 8, 10, tablet ? 20 : 8, 10),
        decoration: const BoxDecoration(gradient: RadialGradient(radius: 1.15, colors: [Color(0xFF35134E), Color(0xFF160D20), Color(0xFF09070C)])),
        child: Column(children: [
          const Row(children: [Expanded(child: _ScoreCard('YOUR TEAM','Kat + Sarah','2,480')), SizedBox(width: 8), Expanded(child: _ScoreCard('OPPONENTS','Mike + Jordan','2,150'))]),
          SizedBox(height: tablet ? 16 : 8),
          _PlayerSeat(name:'Sarah', detail:'Partner · 9 cards', active:false, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PartnerProfileScreen(name:'Sarah')))),
          const Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _PlayerSeat(name:'Mike', detail:'11 cards', active:true, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PartnerProfileScreen(name:'Mike')))),
            Column(children: [Icon(Icons.layers_rounded, size: tablet ? 52 : 38, color: const Color(0xFFC9C4D2)), const Text('DRAW · 38'), const SizedBox(height: 10), Icon(Icons.style_rounded, size: tablet ? 52 : 38, color: const Color(0xFFB46CFF)), const Text('DISCARD · 7')]),
            _PlayerSeat(name:'Jordan', detail:'8 cards', active:false, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PartnerProfileScreen(name:'Jordan')))),
          ]),
          const Spacer(),
          const Text('YOUR HAND', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 6),
          SizedBox(height: cardH, width: double.infinity, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [for(final card in cards) _PlayingCard(card, width: cardW, height: cardH)])),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: FilledButton.icon(onPressed: () => _info(context,'Table Chat','Quick Chat: Good game! · Nice play! · Thank you!\n\nTyped chat and translation will appear here. You can mute individual players or the whole table.'), icon: const Icon(Icons.chat_rounded), label: const Text('Chat'))),
            const SizedBox(width: 8),
            Expanded(child: FilledButton.icon(onPressed: () => _info(context,'Score','Your Team  2,480\nOpponents  2,150\n\nHand details and Canasta bonuses will be shown here.'), icon: const Icon(Icons.scoreboard_rounded), label: const Text('Score'))),
          ]),
        ]),
      );
    })),
  );
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
