import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class BottomSectionWidget extends StatelessWidget {
  const BottomSectionWidget({
    super.key,
    required this.currentWidth,
    required this.currentHeight,
  });

  final double currentWidth;
  final double currentHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: currentWidth * 75,
      height: currentHeight * 0.15,
      color: secondaryColor,
    );
  }
}
