import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';
import 'package:vidspod_mobile/core/widgets/app_network_image.dart';

class GetStartedScreen extends StatelessWidget {
  final String? motionId;
  final String? motionTitle;
  const GetStartedScreen({super.key, this.motionId, this.motionTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SeeDance', style: VrTheme.headingSmall()),
            if (motionTitle != null)
              Text(
                motionTitle!,
                style: VrTheme.caption(color: Colors.white.withAlpha(100)),
              ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () => dismissKeyboard(context),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInputSection(context),
              const SizedBox(height: 20),
              _buildPromptInput(),
              const SizedBox(height: 24),
              _buildGenerateButton(context),
              const SizedBox(height: 12),
              _buildCreditsDisplay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Input', style: VrTheme.headingMedium()),
        const SizedBox(height: 12),
        Row(
          children: [
            Container(
              width: 120,
              height: 160,
              decoration: BoxDecoration(
                color: VrTheme.surfaceDark,
                borderRadius: BorderRadius.circular(VrTheme.radiusLg),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppNetworkImage(
                    url: 'https://picsum.photos/seed/face/200/200',
                    placeholderIcon: Icons.person_outline,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(VrTheme.radiusLg),
                      border: Border.all(color: VrTheme.purple, width: 2),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(180),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '@image1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Upload reference video')),
              ),
              child: Container(
                width: 100,
                height: 130,
                decoration: BoxDecoration(
                  color: VrTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(VrTheme.radiusLg),
                  border: Border.all(color: Colors.white.withAlpha(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white38,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Upload\nmore',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white38, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPromptInput() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: VrTheme.surfaceDark,
        borderRadius: BorderRadius.circular(VrTheme.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextField(
            maxLines: 6,
            decoration: InputDecoration(
              hintText:
                  'Describe your vision — faces, bodies, scenes, camera movement...',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white24, fontSize: 13),
              isCollapsed: true,
            ),
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.auto_awesome,
                    color: VrTheme.purple.withAlpha(150),
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'AI Powered',
                    style: TextStyle(
                      color: VrTheme.purple.withAlpha(150),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                '2879/1000',
                style: VrTheme.caption(color: Colors.white.withAlpha(60)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateButton(BuildContext context) {
    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Starting generation...'))),
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          gradient: VrTheme.brandGradient,
          boxShadow: VrTheme.buttonShadow(VrTheme.purple),
        ),
        child: Center(
          child: Text(
            'Generate',
            style: VrTheme.bodyMedium(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
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
          '50 credits',
          style: VrTheme.bodySmall(color: Colors.white.withAlpha(110)),
        ),
      ],
    );
  }
}
