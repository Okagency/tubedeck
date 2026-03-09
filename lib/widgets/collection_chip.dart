import 'package:flutter/material.dart';

class CollectionChipWidget extends StatelessWidget {
  final String label;
  final Color? color;
  final bool isSelected;
  final VoidCallback onTap;
  final int? channelCount;
  final bool showChannelCount;
  final bool isLarge;

  const CollectionChipWidget({
    super.key,
    required this.label,
    this.color,
    required this.isSelected,
    required this.onTap,
    this.channelCount,
    this.showChannelCount = true,
    this.isLarge = true,
  });

  @override
  Widget build(BuildContext context) {
    final displayLabel = (showChannelCount && channelCount != null)
        ? '$label ($channelCount)'
        : label;

    // 크기에 따른 스타일 설정
    final horizontalPadding = isLarge ? 14.0 : 10.0;
    final verticalPadding = isLarge ? 8.0 : 5.0;
    final fontSize = isLarge ? 14.0 : 12.0;

    // 유튜브 스타일 칩
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.grey[800],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          displayLabel,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
