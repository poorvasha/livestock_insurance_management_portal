import 'dart:js';

import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/HomeScreen.dart';
import '../screens/LoginScreen.dart';
import '../screens/MasterDataEntryScreen.dart';

class Routes {
  static const String loginScreen = 'LoginScreen';
  static const String homeScreen = 'HomeScreen';
  static const String flashScreen = 'FlashScreen';
  static const String masterDataEntryScreen = 'MasterDataEntryScreen';

  static Route<dynamic> RouteController(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case masterDataEntryScreen:
        return MaterialPageRoute(
            builder: (context) => const MasterDataEntryScreen());
      default:
        return MaterialPageRoute(builder: (context) => const FlashScreen());
    }
  }
}
