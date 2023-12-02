import 'package:flutter/material.dart';

import 'package:admin/constants.dart';

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
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Made with ❤️ by the Mehul Kumar, using Flutter Web.",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              "Email: mehul2002kumar@gmail.com",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              "Github: @Mehul-Kumar-27",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
