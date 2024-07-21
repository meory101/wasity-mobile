import 'package:flutter/cupertino.dart';
import 'package:wasity/core/storage/shared/shared_pref.dart';



abstract class ApiErrorMethod {
  static void invalidSessionToken({required BuildContext context}) {

    AppSharedPreferences.clear();
    // Navigator.of(context)
    //     .pushNamedAndRemoveUntil(RouteNamedScreens.login, (route) => false);
  }





  static void noInternetConnection({required BuildContext context}) {
    // Navigator.of(context)
    //     .pushReplacementNamed(RouteNamedScreens.noInternet)
    //     .then((value) => null);
  }


  static void serverError({required BuildContext context}) {
    // Navigator.of(context)
    //     .pushReplacementNamed(RouteNamedScreens.noInternet)
    //     .then((value) => null);
  }
}



