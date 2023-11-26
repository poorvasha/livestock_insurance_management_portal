import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:lsi_management_portal/models/SecureStorageModel.dart';

import '../services/SecureStorageService.dart';

class AppHelper {
  // static Future<bool> checkIsUserLoggedIn() async {
  //   try {
  //     var isContainsKey =
  //         await SecureStorage().containsKeyInSecureData('accessToken');
  //     if (isContainsKey) {
  //       var data = await SecureStorage().readSecureData('accessToken');
  //       if (data != null && data.isNotEmpty) {
  //         return true;
  //       }
  //     }
  //     return false;
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //     return false;
  //   }
  // }

  static Future<bool> checkIsUserLoggedIn() async {
    try {
      var accessToken = await SessionManager().get("accessToken");
          
      if (accessToken != null && accessToken.isNotEmpty) {
        
          return true;
        
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  static Future<void> logoutUser() async {
    await SecureStorage().deleteSecureData('accessToken');
  }

  static Future<void> setAccessToken(String accessToken) async {
    try {
      await SessionManager().set("accessToken", json.encode(accessToken));
      await SecureStorage().writeSecureData(
          SecureStorageModel(key: "accessToken", value: accessToken));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<void> setUserType(String userType) async {
    try {
      await SecureStorage().writeSecureData(
          SecureStorageModel(key: 'userType', value: userType));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static void showSnackbar(String message, BuildContext context) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
