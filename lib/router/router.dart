import 'package:flutter/material.dart';
import 'package:wasity/features/auth/screen/login_screen.dart';
import 'package:wasity/features/auth/screen/verification_code_screen.dart';
import '../core/injection/injection_container.dart' as di;


abstract class RouteNamedScreens {
  static const String init = login;
  static const String splash = "/splash";
  static const String verificationCode = "/verification-code";
  static const String login = "/login";

}

abstract class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    final argument = settings.arguments;

    switch (settings.name) {
      case RouteNamedScreens.login:
        return MaterialPageRoute(builder: (context) {
          return const LoginScreen();
        },);
      case RouteNamedScreens.verificationCode:
        return MaterialPageRoute(builder: (context) {
          return const VerificationCodeScreen();
        },);
    }
    return MaterialPageRoute(builder: (context) {
      return const LoginScreen();
    },);

  }
}
