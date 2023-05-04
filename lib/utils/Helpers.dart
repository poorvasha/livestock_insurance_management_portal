import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../services/SecureStorageService.dart';

class Helpers {
  Future<bool> checkIsUserLoggedIn() async {
    try {
      var isContainsKey =
          await SecureStorage().containsKeyInSecureData('accesstoken');
      if (isContainsKey) {
        var data = await SecureStorage().readSecureData('accesstoken');
        if (data != null && data.isNotEmpty) {
          return true;
        }
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  static bool validateEmail(String email) {
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
      return false;
    } else {
      return true;
    }
  }

  static bool validatePassword(String password) {
    if (password.length < 6) {
      return false;
    } else {
      return true;
    }
  }

  static bool validateName(String name) {
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(name)) {
      return false;
    } else {
      return true;
    }
  }

  static bool validatePhoneNumber(String phoneNumber) {
    if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(phoneNumber)) {
      return false;
    } else {
      return true;
    }
  }
}

enum ScreenType { homeScreen, masterDataEntryScreen }
