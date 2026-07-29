import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavItem(Icons.auto_awesome, 'Creator', true, context),
          _buildNavItem(Icons.business_center, 'Business', false, context),
          _buildNavItem(Icons.campaign, 'Speak', false, context),
          _buildNavItem(Icons.history_edu, 'History', false, context),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected, BuildContext context) {
    final color = isSelected ? Theme.of(context).colorScheme.primary : Colors.grey;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: color),
        Text(label, style: TextStyle(color: color)),
      ],
    );
  }
}
