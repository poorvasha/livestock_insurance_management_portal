import 'dart:js';

import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/HomeScreen.dart';
import '../screens/LoginScreen.dart';

class Routes {
  static const String loginScreen = 'LoginScreen';
  static const String homeScreen = 'HomeScreen';
  static const String flashScreen = 'FlashScreen';

  static Route<dynamic> RouteController(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (context) => const FlashScreen());
    }
  }
}
