// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import '../../resource/key_manger.dart';

abstract class AppSharedPreferences {
  static SharedPreferences? _sharedPreferences;

  // Initialize SharedPreferences
  static Future<void> init(SharedPreferences sh) async {
    _sharedPreferences = sh;
  }

  // Check if SharedPreferences is initialized
  static void checkInitialized() {
    if (_sharedPreferences == null) {
      throw StateError('SharedPreferences has not been initialized.');
    }
  }

  // !Cache client ID
  static void cacheClientId(String clientId) {
    checkInitialized();
    _sharedPreferences!.setString(AppKeyManager.clientIdKey, clientId);
  }

  //! Get cached client ID
  static String getClientId() {
    checkInitialized();
    return _sharedPreferences!.getString(AppKeyManager.clientIdKey) ?? '';
  }

  // Cache default location
  static String getDefaultLocation() {
    checkInitialized();
    return _sharedPreferences!.getString(AppKeyManager.defaultLocation) ?? "";
  }

  // Cache default address ID and location
  static void cacheDefaultAddressId({required String id, required String location}) {
    checkInitialized();
    _sharedPreferences!.setString(AppKeyManager.defaultAddressId, id);
    _sharedPreferences!.setString(AppKeyManager.defaultLocation, location);
  }

  // Get default address ID
  static String getDefaultAddressId() {
    checkInitialized();
    return _sharedPreferences!.getString(AppKeyManager.defaultAddressId) ?? "";
  }

  // Cache guest mode status
  static void cacheGuestMode({required bool isGuest}) {
    checkInitialized();
    _sharedPreferences!.setBool(AppKeyManager.guestModeLocalKey, isGuest);
  }

  // Cache authenticated user information
  static void cacheAuthUserInfo({
    String token = '',
    String userName = '',
    String fullName = '',
    required String phoneNumber,
    required String userId,
  }) {
    checkInitialized();
    if (token.isNotEmpty) {
      _sharedPreferences!.setString(AppKeyManager.token, token);
    }
    if (userName.isNotEmpty) {
      _sharedPreferences!.setString(AppKeyManager.username, userName);
    }
    if (fullName.isNotEmpty) {
      _sharedPreferences!.setString(AppKeyManager.fullName, fullName);
    }
    _sharedPreferences!.setString(AppKeyManager.userId, userId);
    _sharedPreferences!.setString(AppKeyManager.phoneNumber, phoneNumber);
    cacheGuestMode(isGuest: false);
  }

  // Get cached language
  static String getLanguage() {
    checkInitialized();
    return _sharedPreferences!.getString(AppKeyManager.language) ?? "ar";
  }

  // Get cached token
  static String getToken() {
    checkInitialized();
    return _sharedPreferences!.getString(AppKeyManager.token) ?? '';
  }

  // Get cached user name
  static String getUserName() {
    checkInitialized();
    return _sharedPreferences!.getString(AppKeyManager.username) ?? '';
  }

  // Get cached full name
  static String getFullName() {
    checkInitialized();
    return _sharedPreferences!.getString(AppKeyManager.fullName) ?? '';
  }

  // Get cached phone number
  static String getPhoneNumber() {
    checkInitialized();
    return _sharedPreferences!.getString(AppKeyManager.phoneNumber) ?? '';
  }

  //! Get cached user ID
  static String getUserId() {
    checkInitialized();
    return _sharedPreferences!.getString(AppKeyManager.userId) ?? '';
  }

  // Get cached guest mode status
  static bool getCachedGuestMode() {
    checkInitialized();
    return _sharedPreferences!.getBool(AppKeyManager.guestModeLocalKey) ?? true;
  }

  // !Cache cart items
  static void cacheCartItems(String cartItemsJson) {
    checkInitialized();
    _sharedPreferences!.setString(AppKeyManager.cartItemsKey, cartItemsJson);
  }

  // !Get cached cart items
  static String getCartItems() {
    checkInitialized();
    return _sharedPreferences!.getString(AppKeyManager.cartItemsKey) ?? '';
  }
}


