import 'package:flutter/material.dart';

class NameEmailHeaderWidget extends StatelessWidget {
  const NameEmailHeaderWidget({
    super.key,
    required this.currentHeight,
    required this.currentWidth,
  });

  final double currentHeight;
  final double currentWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: currentHeight * 0.01),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "Name",
            style: TextStyle(
                color: Colors.white),
          ),
          SizedBox(
            width: currentWidth * 0.14,
          ),
          const Text(
            "Email",
            style: TextStyle(
                color: Colors.white),
          ),
          SizedBox(
            width: currentWidth * 0.1,
          ),
          const Text(
            "Role",
            style: TextStyle(
                color: Colors.white),
          ),
          SizedBox(
            width: currentWidth * 0.005,
          ),
          const Text(
            "Action",
            style: TextStyle(
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}