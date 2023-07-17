import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';

import '../models/SecureStorageModel.dart';

class SecureStorage {
  final _storage = LocalStorage('some_key');

  Future<void> writeSecureData(SecureStorageModel item) async {
    try {
      await _storage.setItem(item.key, item.value);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<String?> readSecureData(String key) async {
    try {
      String? data = await _storage.getItem(key);
      return data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<void> deleteSecureData(String key) async {
    try {
      await _storage.deleteItem(key);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> clear() async {
    try {
      await _storage.clear();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<bool> containsKeyInSecureData(String key) async {
    var value = await _storage.getItem(key);
    return value != null;
  }
}
