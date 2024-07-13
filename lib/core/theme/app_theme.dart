
// import 'package:flutter/material.dart';
// import 'package:wasity/core/resource/color_manager.dart';
// import 'package:wasity/core/resource/font_manager.dart';
// import 'package:wasity/core/resource/size_manager.dart';

// //!App Text Theme
// TextTheme appTextTheme = TextTheme(
//   displayLarge: TextStyle(
//     fontFamily: FontFamilyManager.cairo,
//     fontSize: FontSizeManager.fs28,
//     fontWeight: FontWeight.w400,
//     color: AppColorManager.white,
//   ),
//   displayMedium: TextStyle(
//     fontFamily: FontFamilyManager.cairo,
//     fontSize: FontSizeManager.fs16,
//     fontWeight: FontWeight.w400,
//     color: AppColorManager.white,
//   ),
//   displaySmall: TextStyle(
//     fontFamily: FontFamilyManager.cairo,
//     fontSize: FontSizeManager.fs14,
//     color: AppColorManager.black,
//     fontWeight: FontWeight.w400,
//   ),
//   headlineLarge: TextStyle(
//     fontFamily: FontFamilyManager.cairo,
//     fontSize: FontSizeManager.fs20,
//     fontWeight: FontWeight.w600,
//     color: AppColorManager.textAppColor,
//   ),
//   headlineMedium: TextStyle(
//     fontFamily: FontFamilyManager.cairo,
//     fontSize: FontSizeManager.fs16,
//     fontWeight: FontWeight.w400,
//     color: AppColorManager.textAppColor,
//   ),
//   headlineSmall: TextStyle(
//     fontFamily: FontFamilyManager.cairo,
//     fontSize: FontSizeManager.fs14,
//     fontWeight: FontWeight.w400,
//     color: AppColorManager.textAppColor,
//   ),
//   titleLarge: TextStyle(
//     fontFamily: FontFamilyManager.cairo,
//     fontSize: FontSizeManager.fs22,
//     fontWeight: FontWeight.w600,
//     color: AppColorManager.white,
//   ),
//   bodyLarge: TextStyle(
//     fontFamily: FontFamilyManager.cairo,
//     fontSize: FontSizeManager.fs14,
//     fontWeight: FontWeight.normal,
//     color: AppColorManager.textAppColor,
//   ),
//   bodyMedium: TextStyle(
//     fontFamily: FontFamilyManager.cairo,
//     fontSize: FontSizeManager.fs14,
//     fontWeight: FontWeight.w400,
//     color: AppColorManager.textAppColor,
//   ),
//   bodySmall: TextStyle(
//     fontFamily: FontFamilyManager.cairo,
//     fontSize: FontSizeManager.fs11,
//     fontWeight: FontWeight.w400,
//     color: AppColorManager.grey,
//   ),
// );


// //!App Light Theme
// ThemeData lightTheme() {
//   return ThemeData(
//     useMaterial3: true,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: AppColorManager.background,
//     ),
//     brightness: Brightness.light,
//     primaryColorLight: AppColorManager.darkOrange,
//     scaffoldBackgroundColor: AppColorManager.background,
//     splashColor: AppColorManager.white,
//     fontFamily: FontFamilyManager.cairo,
//     primaryColor: AppColorManager.darkOrange,
//     textTheme: appTextTheme,
//     progressIndicatorTheme:
//         const ProgressIndicatorThemeData(color: AppColorManager.darkOrange),
//     floatingActionButtonTheme: const FloatingActionButtonThemeData(
//         backgroundColor: AppColorManager.darkOrange,
//         foregroundColor: AppColorManager.darkOrange),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: AppColorManager.white,
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(AppRadiusManager.r5),
//         borderSide: const BorderSide(
//           color: AppColorManager.darkOrange,
//         ),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(AppRadiusManager.r5),
//         borderSide: const BorderSide(
//           color: AppColorManager.darkOrange,
//         ),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(AppRadiusManager.r3),
//         borderSide: BorderSide(color: AppColorManager.greyShadowOpacity1),
//       ),
//       contentPadding: EdgeInsets.symmetric(
//           horizontal: AppWidthManager.w16, vertical: AppHeightManager.h1point5),
//       hintStyle: TextStyle(
//         color: AppColorManager.greyShadowOpacity1,
//         fontSize: FontSizeManager.fs16,
//         fontWeight: FontWeight.normal,
//       ),
//       floatingLabelStyle: const TextStyle(
//         color: AppColorManager.darkOrange,
//       ),
//       iconColor: AppColorManager.darkOrange,
//       focusedBorder: OutlineInputBorder(
//         borderSide: const BorderSide(color: AppColorManager.darkOrange),
//         borderRadius: BorderRadius.circular(AppRadiusManager.r3),
//       ),
//       border: OutlineInputBorder(
//         borderSide: const BorderSide(),
//         borderRadius: BorderRadius.circular(AppRadiusManager.r3),
//       ),
//     ),
//     tabBarTheme: TabBarTheme(
//       indicator: BoxDecoration(
//         color: AppColorManager.darkOrange,
//         borderRadius: BorderRadius.circular(AppRadiusManager.r5),
//       ),
//     ),
//     colorScheme: const ColorScheme.light(primary: AppColorManager.darkOrange)
//         .copyWith(
//             secondary:
//                 AppColorManager.darkOrange), // Define the default button theme
//     buttonTheme: const ButtonThemeData(
//       buttonColor: AppColorManager.darkOrange,
//       textTheme: ButtonTextTheme.primary,
//     ),
//   );
// }