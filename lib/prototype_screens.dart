import 'package:flutter/material.dart';

void showPrototypeInfo(BuildContext context, String title, String body) {
  showDialog(context: context, builder: (_) => AlertDialog(
    title: Text(title), content: Text(body),
    actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Got it'))],
  ));
}

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Learn & Practice')),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      const Text('Learn Canasta by playing it', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
      const Text('Start from zero or jump to the topic you want to practice.'),
      const SizedBox(height: 16),
      for (final lesson in const [
        ('1', 'Your first hand', 'Objective, cards, drawing and discarding'),
        ('2', 'Build your first meld', 'Matching ranks and initial meld requirements'),
        ('3', 'Make a Canasta', 'Natural, mixed and wild cards'),
        ('4', 'The discard pile', 'Pickup rules and the frozen pile'),
        ('5', 'Going out & scoring', 'Finish a hand and understand the score'),
      ])
        Card(child: ListTile(
          leading: CircleAvatar(child: Text(lesson.$1)),
          title: Text(lesson.$2, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(lesson.$3),
          trailing: Icon(lesson.$1 == '1' ? Icons.play_circle_fill_rounded : Icons.lock_outline_rounded),
          onTap: lesson.$1 == '1' ? () => showPrototypeInfo(context, lesson.$2, 'The finished lesson teaches this with cards in your hand and explains each action as you play.') : null,
        )),
      const SizedBox(height: 16),
      FilledButton.icon(
        onPressed: () => showPrototypeInfo(context, 'Coached Practice', 'Hints stay available and explain why a move is legal or useful.'),
        icon: const Icon(Icons.psychology_alt_rounded), label: const Text('Start Coached Practice'),
      ),
    ]),
  );
}

class CompetitiveScreen extends StatelessWidget {
  const CompetitiveScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Competitive Play')),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      const Text('Your competitive game', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(children: [
        const Icon(Icons.emoji_events_rounded, size: 54),
        const Text('Gold III', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('1,426 Rating · Level 37'),
          IconButton(
            onPressed: () => showPrototypeInfo(context, 'How ranking works', 'Gold III is your competitive division. 1,426 is your skill rating and can move with competitive results. Level 37 is overall experience and does not go down when you lose.'),
            icon: const Icon(Icons.info_outline_rounded),
          ),
        ]),
      ]))),
      const SizedBox(height: 12),
      FilledButton.icon(
        onPressed: () => showPrototypeInfo(context, 'Finding a fair match', 'Search begins near Gold III. If the wait grows, Endra Canasta asks before expanding the skill range.'),
        icon: const Icon(Icons.search_rounded), label: const Text('Find Competitive Match'),
      ),
      const SizedBox(height: 8),
      OutlinedButton.icon(
        onPressed: () => showPrototypeInfo(context, 'Partner Queue', 'Invite a friend as your partner, then search for an opposing team. Premade partners are allowed.'),
        icon: const Icon(Icons.group_add_rounded), label: const Text('Invite Partner First'),
      ),
    ]),
  );
}

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Friends & Private Tables')),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      const Text('Your people', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
      const Text('Find players you enjoyed instead of hoping to meet them again by chance.'),
      const SizedBox(height: 16),
      const _FriendTile(name: 'SarahM', status: 'Online · Favorite Partner', favorite: true),
      const _FriendTile(name: 'CardShark82', status: 'In Game'),
      const _FriendTile(name: 'MiaC', status: 'Away'),
      const SizedBox(height: 16),
      FilledButton.icon(
        onPressed: () => showPrototypeInfo(context, 'Invite SarahM', 'SarahM receives a direct invitation. When she accepts, you take partner seats and can find two opponents.'),
        icon: const Icon(Icons.person_add_alt_1_rounded), label: const Text('Invite SarahM to Play'),
      ),
      const SizedBox(height: 8),
      OutlinedButton.icon(
        onPressed: () => showPrototypeInfo(context, 'Private Table', 'Choose rules, invite friends, leave seats open if you want, then start when the table is ready.'),
        icon: const Icon(Icons.table_restaurant_rounded), label: const Text('Create Private Table'),
      ),
      const SizedBox(height: 18),
      const Text('Recent Players', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const ListTile(leading: CircleAvatar(child: Icon(Icons.person)), title: Text('RiverAce'), subtitle: Text('Played 18 minutes ago · Opponent'), trailing: Icon(Icons.person_add_rounded)),
    ]),
  );
}

class _FriendTile extends StatelessWidget {
  final String name, status;
  final bool favorite;
  const _FriendTile({required this.name, required this.status, this.favorite = false});
  @override
  Widget build(BuildContext context) => Card(child: ListTile(
    leading: CircleAvatar(child: Text(name.substring(0, 1))),
    title: Row(children: [Text(name, style: const TextStyle(fontWeight: FontWeight.bold)), if (favorite) const Padding(padding: EdgeInsets.only(left: 6), child: Icon(Icons.star_rounded, size: 18))]),
    subtitle: Text(status), trailing: const Icon(Icons.chevron_right_rounded),
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PartnerProfileScreen(name: name))),
  ));
}

class PartnerProfileScreen extends StatelessWidget {
  final String name;
  const PartnerProfileScreen({super.key, required this.name});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(name)),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      const Center(child: CircleAvatar(radius: 44, child: Icon(Icons.person, size: 44))),
      const SizedBox(height: 10),
      Center(child: Text(name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold))),
      const Center(child: Text('Level 42 · Gold II · Good Sport')),
      const SizedBox(height: 22),
      Text('YOU + ${name.toUpperCase()}', style: const TextStyle(fontWeight: FontWeight.bold)),
      const Card(child: Padding(padding: EdgeInsets.all(16), child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        _Stat('47', 'Games'), _Stat('31', 'Wins'), _Stat('66%', 'Win rate'), _Stat('5', 'Best streak'),
      ]))),
      const ListTile(title: Text('Canastas together'), trailing: Text('86')),
      const ListTile(title: Text('Competitive games together'), trailing: Text('19')),
      const ListTile(title: Text('Last played'), trailing: Text('Today')),
      FilledButton.icon(
        onPressed: () => showPrototypeInfo(context, 'Invitation sent', 'Prototype: this becomes a real invitation when accounts and realtime services are connected.'),
        icon: const Icon(Icons.play_arrow_rounded), label: const Text('Invite to Play'),
      ),
      const SizedBox(height: 8),
      OutlinedButton.icon(
        onPressed: () => showPrototypeInfo(context, 'Shared Match History', 'This filters match history to games involving both of you, including games as partners and opponents.'),
        icon: const Icon(Icons.history_rounded), label: const Text('Match History'),
      ),
    ]),
  );
}

class _Stat extends StatelessWidget {
  final String value, label;
  const _Stat(this.value, this.label);
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    Text(label, style: const TextStyle(fontSize: 11)),
  ]);
}
