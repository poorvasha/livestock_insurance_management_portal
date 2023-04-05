import 'package:flutter/material.dart';

class Resources {
  static const Color primaryColor = Color(0xFF752b56);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFfffffff);
  static const Color linkBlue = Color(0xFF0d99ff);
  static const Color red = Color.fromARGB(227, 223, 1, 1);

  static List<BoxShadow> customShadow = [
    BoxShadow(
        color: primaryColor.withOpacity(0.2),
        spreadRadius: 0,
        offset: const Offset(-4, -4),
        blurRadius: 8,
        blurStyle: BlurStyle.outer)
  ];
}
