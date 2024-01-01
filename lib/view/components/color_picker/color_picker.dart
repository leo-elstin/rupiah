import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ColorPicker extends StatelessWidget {
  final ValueChanged<String> onSelect;

  const ColorPicker({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: Wrap(
          children: colors
              .map(
                (int e) => IconButton.filledTonal(
                  onPressed: () {
                    context.pop();
                    print(Colors.red.value);
                    onSelect(e.toString());
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      color: Color(e),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    width: 24,
                    height: 24,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

List<int> colors = [
  0xFF191970, // Midnight Blue
  0xFF0000CD, // Medium Blue
  0xFF4169E1, // Royal Blue
  0xFF4682B4, // Steel Blue
  0xFF87CEEB, // Sky Blue
  0xFF00CED1, // Dark Turquoise
  0xFF20B2AA, // Light Sea Green
  0xFF008080, // Teal
  0xFF008B8B, // Dark Cyan
  0xFF00FFFF, // Cyan
  0xFF7FFFD4, // Aquamarine
  0xFF00FF7F, // Spring Green
  0xFFADFF2F, // Green Yellow
  0xFF32CD32, // Lime Green
  0xFF228B22, // Forest Green
  0xFF006400, // Dark Green
  0xFF8FBC8F, // Dark Sea Green
  0xFF556B2F, // Dark Olive Green
  0xFFBDB76B, // Dark Khaki
  0xFFDAA520, // Goldenrod
  0xFFFFD700, // Gold
  0xFFB8860B, // Dark Goldenrod
  0xFFFFA500, // Orange
  0xFFFF4500, // Orange Red
  0xFFB22222, // Fire Brick
  0xFFDC143C, // Crimson
  0xFF8B0000, // Dark Red
  0xFFA9A9A9, // Dark Gray
  0xFF808080, // Gray
];
