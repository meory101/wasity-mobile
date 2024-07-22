import 'package:flutter/material.dart';
import 'package:wasity/core/navigation/fade_builder_route.dart';
import 'package:wasity/features/auth/presentation/generate_otp_cubit/delivery_location_cubit.dart';
import '../core/injection/injection_container.dart' as di;
import '../features/auth/presentation/screen/generate_otp.dart';
import '../features/auth/presentation/screen/verification_code_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return FadeBuilderRoute(
          page: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => di.sl<GenerateOtpCubit>(),
              ),
            ],
            child: const GenerateOtpScreen(),
          ),
        );

      case RouteNamedScreens.verificationCode:
        return MaterialPageRoute(
          builder: (context) {
            return const VerificationCodeScreen();
          },
        );
    }
    return MaterialPageRoute(
      builder: (context) {
        return const GenerateOtpScreen();
      },
    );
  }
}
