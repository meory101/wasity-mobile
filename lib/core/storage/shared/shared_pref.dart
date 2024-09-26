// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import '../../resource/key_manger.dart';

abstract class AppSharedPreferences {
  static SharedPreferences? _sharedPreferences;

  static Future<void> init(SharedPreferences sh) async {
    _sharedPreferences = sh;
  }

  static void checkInitialized() {
    if (_sharedPreferences == null) {
      throw StateError('SharedPreferences has not been initialized.');
    }
  }

  // ! Cache default address ID and location
   //? Cache selected address ID and location
  static void cacheSelectedAddressId({
    required String id,
    required String location,
  }) {
    checkInitialized();
    _sharedPreferences!.setString(AppKeyManager.selectedAddressId, id);
    _sharedPreferences!.setString(AppKeyManager.selectedLocation, location);
  }

  //? Get cached selected address ID
  static String? getSelectedAddressId() {
    checkInitialized();
    return _sharedPreferences!.getString(AppKeyManager.selectedAddressId);
  }

  //? Get cached selected location
  static String? getSelectedLocation() {
    checkInitialized();
    return _sharedPreferences!.getString(AppKeyManager.selectedLocation);
  }
  //! Cache client ID
  static void cacheClientId(String clientId) {
    checkInitialized();
    _sharedPreferences!.setString(AppKeyManager.clientIdKey, clientId);
  }

  //! Get cached client ID
  static String getClientId() {
    checkInitialized();
    return _sharedPreferences!.getString(AppKeyManager.clientIdKey) ?? '';
  }

  //! Cache delivery type
  static void cacheDeliveryType(int deliveryType) {
    checkInitialized();
    _sharedPreferences!.setInt(AppKeyManager.deliveryTypeKey, deliveryType);
  }

  //!cache Profile Image
  static void cacheProfileImage(String imagePath) {
    checkInitialized();
    _sharedPreferences!.setString(AppKeyManager.profileImageKey, imagePath);
  }

//!Get Profile Image
  static String getProfileImage() {
    checkInitialized();
    return _sharedPreferences!.getString(AppKeyManager.profileImageKey) ?? '';
  }

  //!Cache full name
  static void cacheFullName(String fullName) {
    checkInitialized();
    _sharedPreferences!.setString(AppKeyManager.fullName, fullName);
  }

//!get FullName
  static String getFullName() {
    checkInitialized();
    return _sharedPreferences!.getString(AppKeyManager.fullName) ?? '';
  }

  //! Cache points
  static void cachePoints(int points) {
    checkInitialized();
    _sharedPreferences!.setInt(AppKeyManager.pointsKey, points);
  }

  //! Get cached points
  static int getPoints() {
    checkInitialized();
    return _sharedPreferences!.getInt(AppKeyManager.pointsKey) ?? 0;
  }
  //! Get cached delivery type
  static int getDeliveryType() {
    checkInitialized();
    return _sharedPreferences!.getInt(AppKeyManager.deliveryTypeKey) ?? 0;
  }

  //?Cart
  //!Cache cart items
  static void cacheCartItems(String cartItemsJson) {
    checkInitialized();
    _sharedPreferences!.setString(AppKeyManager.cartItemsKey, cartItemsJson);
  }

  //! Get cached cart items
  static String getCartItems() {
    checkInitialized();
    return _sharedPreferences!.getString(AppKeyManager.cartItemsKey) ?? '';
  }

  static void cacheDefaultAddressId({required String id, required String location}) {}
//   // Get default address ID

//   static String getDefaultAddressId() {
//     checkInitialized();
//     return _sharedPreferences!.getString(AppKeyManager.defaultAddressId) ?? "";
//   }

//   // Cache guest mode status
//   static void cacheGuestMode({required bool isGuest}) {
//     checkInitialized();
//     _sharedPreferences!.setBool(AppKeyManager.guestModeLocalKey, isGuest);
//   }

//   //Cache authenticated user information
//   static void cacheAuthUserInfo({
//     String token = '',
//     String userName = '',
//     String fullName = '',
//     required String phoneNumber,
//     required String userId,
//   }) {
//     checkInitialized();
//     if (token.isNotEmpty) {
//       _sharedPreferences!.setString(AppKeyManager.token, token);
//     }
//     if (userName.isNotEmpty) {
//       _sharedPreferences!.setString(AppKeyManager.username, userName);
//     }
//     if (fullName.isNotEmpty) {
//       _sharedPreferences!.setString(AppKeyManager.fullName, fullName);
//     }
//     _sharedPreferences!.setString(AppKeyManager.userId, userId);
//     _sharedPreferences!.setString(AppKeyManager.phoneNumber, phoneNumber);
//     cacheGuestMode(isGuest: false);
//   }

//   //Get cached language
//   static String getLanguage() {
//     checkInitialized();
//     return _sharedPreferences!.getString(AppKeyManager.language) ?? "ar";
//   }

//   //Get cached token
//   static String getToken() {
//     checkInitialized();
//     return _sharedPreferences!.getString(AppKeyManager.token) ?? '';
//   }
//   // Get cached phone number
//   static String getPhoneNumber() {
//     checkInitialized();
//     return _sharedPreferences!.getString(AppKeyManager.phoneNumber) ?? '';
//   }

//   // Get cached guest mode status
//   static bool getCachedGuestMode() {
//     checkInitialized();
//     return _sharedPreferences!.getBool(AppKeyManager.guestModeLocalKey) ?? true;
//   }

//   // Cache default location
//   static String getDefaultLocation() {
//     checkInitialized();
//     return _sharedPreferences!.getString(AppKeyManager.defaultLocation) ?? "";
//   }

// }
}
