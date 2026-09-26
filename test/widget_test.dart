import 'package:endra_canasta/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('home exposes core play areas', (tester) async {
    await tester.pumpWidget(const EndraCanastaApp());
    expect(find.text('Learn & Practice'), findsOneWidget);
    expect(find.text('Solo Play'), findsOneWidget);
    expect(find.text('Casual Play'), findsOneWidget);
    expect(find.text('Competitive Play'), findsOneWidget);
    expect(find.text('Friends & Private Tables'), findsOneWidget);
  });
}
