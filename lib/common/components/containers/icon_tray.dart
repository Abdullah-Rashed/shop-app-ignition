import 'package:flutter/material.dart';

class IconTray extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double? borderRadius;
  const IconTray(
      {super.key, required this.child, this.onTap, this.borderRadius = 8});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: child,
      ),
    );
  }
}
