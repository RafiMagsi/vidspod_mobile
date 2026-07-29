import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vidspod_mobile/app/app.dart';

void main() {
  testWidgets('preview app shell renders the dashboard', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: VidsPodApp()));
    await tester.pump();

    expect(find.text('Dashboard'), findsOneWidget);
  });
}
