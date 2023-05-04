import 'package:flutter/material.dart';

import '../configs/Resources.dart';
import '../utils/Helpers.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.screenType});
  final ScreenType screenType;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: Resources.customShadow),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 100,
      child: Row(
        children: [
          Image.asset(
            "../assets/images/dhan_logo.jpg",
            height: 65,
            width: 65,
          ),
          const SizedBox(
            width: 15,
          ),
          const Text(
            "Dhan Foundation Admin Portal",
            style: TextStyle(
                fontSize: 24,
                color: Resources.primaryColor,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: onPressed,
            icon: Icon(
              screenType == ScreenType.homeScreen
                  ? Icons.add_rounded
                  : Icons.keyboard_arrow_left,
              size: 48,
              color: Resources.primaryColor,
            ),
            label: Text(
                screenType == ScreenType.homeScreen ? "New Data" : "Dashboard",
                style: const TextStyle(
                    fontSize: 20,
                    color: Resources.primaryColor,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            width: 60,
          ),
          TextButton.icon(
              onPressed: onPressed,
              icon: const Icon(
                Icons.logout,
                size: 48,
                color: Resources.primaryColor,
              ),
              label: const Text("Logout",
                  style: TextStyle(
                      fontSize: 20,
                      color: Resources.primaryColor,
                      fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }

  void onPressed() {}
}
