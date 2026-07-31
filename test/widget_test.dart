import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidspod_mobile/app/app.dart';

void main() {
  testWidgets('preview app shell renders the shorts studio home', (
    WidgetTester tester,
  ) async {
    GoogleFonts.config.allowRuntimeFetching = false;

    await tester.pumpWidget(const ProviderScope(child: VidsPodApp()));

    // Advance past the splash screen's 2-second delay
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();

    // Suppress google_fonts exceptions (fonts not bundled in tests)
    while (tester.takeException() != null) {}

    expect(find.text('Shorts Studio'), findsOneWidget);
    expect(find.text('Start From Photo'), findsOneWidget);
  });
}
