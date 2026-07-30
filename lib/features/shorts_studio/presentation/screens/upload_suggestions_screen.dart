import 'package:flutter/material.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';

class UploadSuggestionsScreen extends StatelessWidget {
  const UploadSuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Upload suggestions', style: CreatiTheme.headingSmall()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _GoodExamples(),
            const SizedBox(height: 28),
            _BadExamples(),
            const SizedBox(height: 32),
            _ActionButtons(),
          ],
        ),
      ),
    );
  }
}

class _GoodExamples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.green.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Good photo examples',
              style: CreatiTheme.headingSmall(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _GoodCard(
                'Single product',
                'Clean background',
                'https://picsum.photos/seed/g1/200/300',
              ),
              const SizedBox(width: 12),
              _GoodCard(
                'Full product shot',
                'Well lit scene',
                'https://picsum.photos/seed/g2/200/300',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GoodCard extends StatelessWidget {
  final String title, subtitle, url;
  const _GoodCard(this.title, this.subtitle, this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
        color: CreatiTheme.surfaceDark,
        boxShadow: CreatiTheme.cardShadow(CreatiTheme.black),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withAlpha(200)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.all(12),
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CreatiTheme.bodySmall(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: CreatiTheme.caption(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BadExamples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.cancel, color: Colors.red, size: 18),
            ),
            const SizedBox(width: 10),
            Text(
              'Bad photo examples',
              style: CreatiTheme.headingSmall(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _BadCard('Multiple items'),
              const SizedBox(width: 12),
              _BadCard('With model'),
              const SizedBox(width: 12),
              _BadCard('Incomplete'),
            ],
          ),
        ),
      ],
    );
  }
}

class _BadCard extends StatelessWidget {
  final String label;
  const _BadCard(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: CreatiTheme.surfaceDark,
        borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
        border: Border.all(color: Colors.red.withAlpha(50)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.block, color: Colors.red.withAlpha(130), size: 28),
          const SizedBox(height: 8),
          Text(
            label,
            style: CreatiTheme.bodyMedium(color: Colors.white.withAlpha(100)),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(27),
              gradient: CreatiTheme.brandGradient,
              boxShadow: CreatiTheme.buttonShadow(CreatiTheme.purple),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white.withAlpha(230),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'From Camera',
                  style: CreatiTheme.bodyMedium(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.white.withAlpha(30)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(27),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            minimumSize: const Size(double.infinity, 54),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.photo_library_outlined,
                color: Colors.white.withAlpha(150),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'From Photo',
                style: CreatiTheme.bodyMedium(
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withAlpha(150),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
