import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class SideSectionWidget extends StatelessWidget {
  const SideSectionWidget({
    super.key,
    required this.currentRatio,
    required this.currentWidth,
    required this.currentHeight,
  });

  final double currentRatio;
  final double currentWidth;
  final double currentHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: currentRatio * 10.0, left: currentRatio * 10),
      child: Container(
          width: currentWidth * 0.2,
          height: currentHeight,
          color: secondaryColor,
          child: Container()),
    );
  }
}
