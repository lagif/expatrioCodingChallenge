import 'package:flutter/material.dart';

class IconTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final MainAxisAlignment alignment;
  final Color color;
  final double fontSize;
  final double iconSize;

  const IconTitle({
    super.key,
    required this.icon,
    required this.title,
    this.alignment = MainAxisAlignment.start,
    this.color = Colors.black87,
    this.iconSize = 24,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: alignment,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: color,
          ),
          const SizedBox(
            width: 12,
          ),
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: fontSize,
              ),
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}
