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
    double width = currentWidth * 0.2;
    double height = currentHeight * 0.2;
    return Padding(
      padding:
          EdgeInsets.only(bottom: currentRatio * 10.0, left: currentRatio * 10),
      child: Container(
          width: currentWidth * 0.2,
          height: currentHeight,
          color: secondaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width,
                height: height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueAccent.withOpacity(0.1),
                      Colors.blueAccent,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Dashboard",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.analytics,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Analytics",
                          style: TextStyle(color: Colors.white),
                        )),
                    TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.calendar_view_week,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Calandar",
                          style: TextStyle(color: Colors.white),
                        )),
                    TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.monetization_on,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Finance",
                          style: TextStyle(color: Colors.white),
                        )),
                    TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Messages",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: currentHeight * 0.5,
                width: width,
              )
            ],
          )),
    );
  }
}
