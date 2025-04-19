import 'package:flutter/material.dart';
import 'package:shop_app/common/theme/colors.dart';

class CategoryTray extends StatelessWidget {
  final String name;
  final bool selected;
  const CategoryTray({super.key, required this.name, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: selected ? MyLightColors.primaryColor : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        name,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black,
          fontSize: 15,
        ),
      ),
    );
  }
}
