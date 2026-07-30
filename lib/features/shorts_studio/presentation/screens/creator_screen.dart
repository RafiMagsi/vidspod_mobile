import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';

class CreatorScreen extends ConsumerWidget {
  const CreatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: CreatiTheme.black,
      appBar: AppBar(
        backgroundColor: CreatiTheme.black,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white.withAlpha(15), shape: BoxShape.circle),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Creator', style: CreatiTheme.headingSmall()),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white.withAlpha(15), shape: BoxShape.circle),
              child: const Icon(Icons.search, color: Colors.white, size: 20),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.person_outline, color: Colors.white.withAlpha(40), size: 64),
          const SizedBox(height: 16),
          Text('Creator Space', style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w500, color: Colors.white.withAlpha(80))),
        ]),
      ),
    );
  }
}
