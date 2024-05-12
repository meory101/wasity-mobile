import 'package:shared_preferences/shared_preferences.dart';

import '../../resource/key_manger.dart';

abstract class AppSharedPreferences {
  static late SharedPreferences _sharedPreferences;

  static init(SharedPreferences sh) {
    _sharedPreferences = sh;
  }

  static clear() {
    _sharedPreferences.clear();
  }



  static String getDefaultLocation() {
    return _sharedPreferences.getString(AppKeyManager.defaultLocation) ?? "";
  }

  static void cashDefaultAddressId({required String id,required String location}) {
    _sharedPreferences.setString(AppKeyManager.defaultAddressId, id);
    _sharedPreferences.setString(AppKeyManager.defaultLocation, location);
  }

  static String getDefaultAddressId() {
    return _sharedPreferences.getString(AppKeyManager.defaultAddressId) ?? "";
  }


  static cashLanguage({required String language}) {
    _sharedPreferences.setString(AppKeyManager.language, language);
  }

  static cashGuestMode({required bool isGuest}) {
    _sharedPreferences.setBool(AppKeyManager.guestModeLocalKey, isGuest);
  }

  static void cacheAuthUserInfo({
    String token = '',
    String userName = '',
    String fullName = '',
    required String phoneNumber,
    required String userId,
  }) {
    if (token.isNotEmpty) {
      _sharedPreferences.setString(AppKeyManager.token, token);
    }
    if (userName.isNotEmpty) {
      _sharedPreferences.setString(AppKeyManager.username, userName);
    }
    if (fullName.isNotEmpty) {
      _sharedPreferences.setString(AppKeyManager.fullName, fullName);
    }
    _sharedPreferences.setString(AppKeyManager.userId, userId);
    _sharedPreferences.setString(AppKeyManager.phoneNumber, phoneNumber);
    cashGuestMode(isGuest: false);
  }

  static String getLanguage() {
    return _sharedPreferences.getString(AppKeyManager.language) ?? "ar";
  }

  static String getToken() {
    return _sharedPreferences.getString(AppKeyManager.token) ?? '';
  }

  static String getUserName() {
    return _sharedPreferences.getString(AppKeyManager.username) ?? '';
  }

  static String getFullName() {
    return _sharedPreferences.getString(AppKeyManager.fullName) ?? '';
  }

  static String getPhoneNumber() {
    return _sharedPreferences.getString(AppKeyManager.phoneNumber) ?? '';
  }

  static String getUserId() {
    return _sharedPreferences.getString(AppKeyManager.userId) ?? '';
  }

  static bool getCashedGuestMode() {
    return _sharedPreferences.getBool(AppKeyManager.guestModeLocalKey) ?? true;
  }
}
