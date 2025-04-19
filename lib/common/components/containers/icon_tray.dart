import 'package:flutter/material.dart';

class IconTray extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onTap;
  const IconTray({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 55,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: icon,
      ),
    );
  }
}
