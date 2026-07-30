import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';

class MotionDetailScreen extends StatelessWidget {
  final String publicGuid;
  const MotionDetailScreen({super.key, required this.publicGuid});

  static const Map<String, Map<String, String>> _motionData = {
    'demo-motion-1': {
      'title': 'Conquer Yourself',
      'desc': 'Face your fears and unlock your true potential',
      'img': 'motion1',
    },
    'demo-motion-2': {
      'title': 'Eternal Dance',
      'desc': 'Let the rhythm move your soul',
      'img': 'motion2',
    },
    'demo-motion-3': {
      'title': 'Ocean Waves',
      'desc': 'Ride the waves of creativity',
      'img': 'motion3',
    },
    'demo-motion-4': {
      'title': 'Urban Pulse',
      'desc': 'Feel the heartbeat of the city',
      'img': 'motion4',
    },
    'demo-video-1': {
      'title': 'Motion Blast',
      'desc': 'High energy video effects',
      'img': 'video1',
    },
    'demo-video-2': {
      'title': 'Smooth Transition',
      'desc': 'Seamless video transitions',
      'img': 'video2',
    },
    'demo-video-3': {
      'title': 'Epic Cinematic',
      'desc': 'Cinema-grade video production',
      'img': 'video3',
    },
    'demo-video-4': {
      'title': 'Vintage Vibes',
      'desc': 'Retro style video effects',
      'img': 'video4',
    },
    'demo-media-1': {
      'title': 'AI Dreamscape',
      'desc': 'AI-generated dream sequences',
      'img': 'media1',
    },
    'demo-media-2': {
      'title': 'Neural Vision',
      'desc': 'Neural network visualizations',
      'img': 'media2',
    },
    'demo-media-3': {
      'title': 'Pixel Perfect',
      'desc': 'Perfect pixel art animations',
      'img': 'media3',
    },
    'demo-media-4': {
      'title': 'Cosmic Journey',
      'desc': 'Journey through the cosmos',
      'img': 'media4',
    },
  };

  Map<String, String> get _data =>
      _motionData[publicGuid] ?? _motionData['demo-motion-1']!;

  @override
  Widget build(BuildContext context) {
    final data = _data;
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            'https://picsum.photos/seed/${data['img']}/800/1280',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (_, __, ___) => Container(color: Colors.black),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withAlpha(180)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(100),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        onPressed: () => context.pop(),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          borderRadius: BorderRadius.circular(
                            CreatiTheme.radiusMd,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.bolt, color: Colors.amber, size: 14),
                            SizedBox(width: 4),
                            Text(
                              '50',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Text(
                        data['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          height: 1.1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data['desc']!,
                        style: CreatiTheme.bodyMedium(
                          color: Colors.white.withAlpha(128),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GestureDetector(
                    onTap: () => context.push(
                      '/get-started',
                      extra: {
                        'motionId': publicGuid,
                        'motionTitle': data['title'],
                      },
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: CreatiTheme.brandGradient,
                        boxShadow: CreatiTheme.buttonShadow(CreatiTheme.purple),
                      ),
                      child: const Center(
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
