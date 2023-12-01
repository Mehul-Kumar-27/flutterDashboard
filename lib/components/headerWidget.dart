
import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.currentHeight,
    required this.currentWidth,
    required this.currentRatio,
  });

  final double currentHeight;
  final double currentWidth;
  final double currentRatio;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: currentHeight * 0.1,
      width: currentWidth,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: currentRatio * 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Image.asset("assets/logo.png"),
            ),
            Container(
              child: Row(children: [
                IconButton(
                    hoverColor: secondaryColor,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    )),
                IconButton(
                    hoverColor: secondaryColor,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    )),
              ]),
            )
          ],
        ),
      ),
    );
  }
}