//Check Network Connection Function
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import '../resource/constant_manager.dart';



abstract class NetworkHelper {
//Connection Checker Function
  static Future<CheckConnectionModel> checkInternetConnection() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      return checkMobileInternetConnection();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return checkWifiInternetConnection();
    } else if (connectivityResult == ConnectivityResult.vpn) {
      return checkVpnInternetConnection();
    } else if (connectivityResult == ConnectivityResult.other) {
      return checkOtherInternetConnection();
    }

    return CheckConnectionModel(
        isConnected: false,
        message: "pleaseTurnOnWifiOrMobileData".tr());
  }

  static Future<CheckConnectionModel> checkMobileInternetConnection() async {
    final List<InternetAddress> result = await InternetAddress.lookup(
        AppConstantManager.appIpConnectionTest,
        type: InternetAddressType.any);

    bool isConnected =
        (result.isNotEmpty && result.first.rawAddress.isNotEmpty);
    return CheckConnectionModel(
        isConnected: isConnected,
        message: isConnected
            ? 'Connected'
            : "");
  }

  static Future<CheckConnectionModel> checkWifiInternetConnection() async {
    final List<InternetAddress> result = await InternetAddress.lookup(
        AppConstantManager.appIpConnectionTest,
        type: InternetAddressType.any);

    bool isConnected =
        (result.isNotEmpty && result.first.rawAddress.isNotEmpty);
    return CheckConnectionModel(
        isConnected: isConnected,
        message: isConnected
            ? 'Connected'
            : "");
  }

  static Future<CheckConnectionModel> checkVpnInternetConnection() async {
    final List<InternetAddress> result = await InternetAddress.lookup(
        AppConstantManager.appIpConnectionTest,
        type: InternetAddressType.any);

    bool isConnected =
        (result.isNotEmpty && result.first.rawAddress.isNotEmpty);
    return CheckConnectionModel(
        isConnected: isConnected,
        message: isConnected
            ? 'Connected'
            : "");
  }

  static Future<CheckConnectionModel> checkOtherInternetConnection() async {
    final List<InternetAddress> result = await InternetAddress.lookup(
        AppConstantManager.appIpConnectionTest,
        type: InternetAddressType.any);

    bool isConnected =
        (result.isNotEmpty && result.first.rawAddress.isNotEmpty);
    return CheckConnectionModel(
        isConnected: isConnected,
        message: isConnected
            ? 'Connected'
            : "");
  }
}

class CheckConnectionModel {
  final String message;
  final bool isConnected;

  CheckConnectionModel({
    required this.message,
    required this.isConnected,
  });
}
