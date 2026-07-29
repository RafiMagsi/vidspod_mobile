import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/core/widgets/gradient_button.dart';

class MotionDetailScreen extends StatelessWidget {
  final String publicGuid;

  const MotionDetailScreen({super.key, required this.publicGuid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image or Video
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://picsum.photos/seed/picsum/800/1280'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // App Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text('Conquer Yourself'),
            ),
          ),
          // Get Started Button
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: GradientButton(
              text: 'Get Started',
              onPressed: () {
                context.push('/get-started');
              },
            ),
          ),
        ],
      ),
    );
  }
}
