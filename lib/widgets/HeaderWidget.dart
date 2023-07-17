import 'package:flutter/material.dart';
import 'package:lsi_management_portal/screens/HomeScreen.dart';
import 'package:lsi_management_portal/screens/MasterDataEntryScreen.dart';

import '../configs/Resources.dart';
import '../utils/Helpers.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.screenType});
  final ScreenType screenType;

  @override
  Widget build(BuildContext context) {
    void onPressed() {
      if (screenType == ScreenType.homeScreen) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MasterDataEntryScreen()));
        return;
      }

      if (screenType == ScreenType.masterDataEntryScreen) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    }

    return Container(
      decoration: BoxDecoration(boxShadow: Resources.customShadow, color: Resources.primaryColor),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 70,
      child: Row(
        children: [
          Image.asset(
            "../assets/images/dhan_logo.jpg",
            height: 45,
            width: 65,
          ),
          const SizedBox(
            width: 15,
          ),
          const Text(
            "Dhan Foundation Admin Portal",
            style: TextStyle(
                fontSize: 18,
                color: Resources.white,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: onPressed,
            icon: Icon(
              screenType == ScreenType.homeScreen
                  ? Icons.add_rounded
                  : Icons.keyboard_arrow_left,
              size: 24,
              color: Resources.white,
            ),
            label: Text(
                screenType == ScreenType.homeScreen ? "New Data" : "Dashboard",
                style: const TextStyle(
                    fontSize: 16,
                    color: Resources.white,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            width: 60,
          ),
          TextButton.icon(
              onPressed: onPressed,
              icon: const Icon(
                Icons.logout,
                size: 24,
                color: Resources.white,
              ),
              label: const Text("Logout",
                  style: TextStyle(
                      fontSize: 16,
                      color: Resources.white,
                      fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }
}
