import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int? currentIndex;
  final ValueChanged<int>? onTap;

  const CustomBottomNavBar({
    super.key,
    this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavItem(Icons.person_outline, 'Creator', 0, context),
          _buildNavItem(Icons.business_center_outlined, 'Business', 1, context),
          _buildNavItem(Icons.record_voice_over_outlined, 'Speak', 2, context),
          _buildNavItem(Icons.history_outlined, 'History', 3, context),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, BuildContext context) {
    final isSelected = currentIndex == index;
    final color = isSelected ? Theme.of(context).colorScheme.primary : Colors.grey;
    return InkWell(
      onTap: () => onTap?.call(index),
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: color),
            Text(label, style: TextStyle(color: color, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
