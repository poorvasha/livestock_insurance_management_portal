import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/SecureStorageModel.dart';

class SecureStorage {
  final _secureStorage = const FlutterSecureStorage();

  Future<void> writeSecureData(SecureStorageModel item) async {
    try {
      await _secureStorage.write(
          key: item.key, value: item.value, aOptions: _getAndroidOptions());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<String?> readSecureData(String key) async {
    try {
      String? data =
          await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
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
      await _secureStorage.delete(key: key, aOptions: _getAndroidOptions());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<List<SecureStorageModel>?> readAllSecureData() async {
    try {
      Map<String, String> allData =
          await _secureStorage.readAll(aOptions: _getAndroidOptions());
      List<SecureStorageModel> mappedData = allData.entries
          .map((e) => SecureStorageModel(key: e.key, value: e.value))
          .toList();
      return mappedData;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<void> deleteAllSecureData(String key) async {
    try {
      await _secureStorage.deleteAll(aOptions: _getAndroidOptions());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<bool> containsKeyInSecureData(String key) async {
    bool containsKey = await _secureStorage.containsKey(
        key: key, aOptions: _getAndroidOptions());
    return containsKey;
  }

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
}
