import 'package:flutter/material.dart';

class IconTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final MainAxisAlignment alignment;
  final Color color;

  const IconTitle({
    super.key,
    required this.icon,
    required this.title,
    this.alignment = MainAxisAlignment.start,
    this.color = Colors.black87,
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
            size: 24,
            color: color,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 18,
            ),
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
