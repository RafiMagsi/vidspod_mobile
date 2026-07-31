import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidspod_mobile/features/tools/presentation/screens/script_writer_screen.dart';
import 'package:vidspod_mobile/features/tools/presentation/screens/voice_studio_screen.dart';

void main() {
  Future<void> pump(WidgetTester tester, Widget child) async {
    GoogleFonts.config.allowRuntimeFetching = false;
    await tester.pumpWidget(ProviderScope(child: MaterialApp(home: child)));
    await tester.pump();
  }

  testWidgets('voice studio renders the catalog in preview mode', (
    WidgetTester tester,
  ) async {
    await pump(tester, const VoiceStudioScreen());

    expect(find.text('Voice Studio'), findsOneWidget);
    expect(find.text('Available Voices'), findsOneWidget);

    // Preview catalog loads after a 200ms delay.
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();
    while (tester.takeException() != null) {}

    expect(find.text('Daniel'), findsOneWidget);
    expect(find.text('Available Voices'), findsOneWidget);
  });

  testWidgets('script writer generates a canned script in preview mode', (
    WidgetTester tester,
  ) async {
    await pump(tester, const ScriptWriterScreen());

    expect(find.text('Script Writer'), findsOneWidget);
    expect(find.text('Generate Script'), findsOneWidget);

    await tester.enterText(
      find.byType(TextField),
      'Review the latest smartphone',
    );
    await tester.tap(find.text('Generate Script'));
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();
    while (tester.takeException() != null) {}

    expect(find.text('Your script'), findsOneWidget);
    expect(find.textContaining('Hook:'), findsOneWidget);
  });
}
