import 'package:flutter/material.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';

class ProductUploadScreen extends StatelessWidget {
  const ProductUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('More options'))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProductImage(),
            const SizedBox(height: 20),
            _buildProductInfo(),
            const SizedBox(height: 28),
            _buildUploadButton(context),
            const SizedBox(height: 12),
            _buildCreditsDisplay(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      height: 320,
      decoration: BoxDecoration(
        color: CreatiTheme.surfaceDark,
        borderRadius: BorderRadius.circular(18),
        image: const DecorationImage(
          image: NetworkImage('https://picsum.photos/seed/product/400/500'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withAlpha(128)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(150),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                '1/3',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(150),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.fullscreen,
                color: Colors.white,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CLEAR CARE EMULSION',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Skincare product — 200ml',
          style: CreatiTheme.bodyMedium(color: Colors.white.withAlpha(100)),
        ),
      ],
    );
  }

  Widget _buildUploadButton(BuildContext context) {
    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('File upload started'))),
      child: Container(
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
              Icons.cloud_upload_outlined,
              color: Colors.white.withAlpha(230),
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Upload Product Image',
              style: CreatiTheme.bodyMedium(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditsDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.bolt, color: Colors.amber.shade300, size: 16),
        const SizedBox(width: 6),
        Text(
          '150 credits',
          style: CreatiTheme.bodySmall(color: Colors.white.withAlpha(110)),
        ),
      ],
    );
  }
}
