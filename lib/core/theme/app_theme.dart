import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';

//! App Text Theme
TextTheme appTextTheme = TextTheme(
  //! العناوين الكبيرة
  //? (ر-السعر بالبرودكت-الوصف بالهوم للكونتبنرات فوقن -اسم المنتج بالبرودكت)
  headlineLarge: TextStyle(
    fontSize: FontSizeManager.fs21,
    fontWeight: FontWeight.w400,
    color: AppColorManager.grey,
  ),

  //! العناوين المتوسطة
  //? (اسم المنتج بالكونتينر-سعر كونتينر-فيومور اوفر)
  headlineMedium: TextStyle(
    fontSize: FontSizeManager.fs20,
    fontWeight: FontWeight.w400,
    color: AppColorManager.white,
  ),

  //! العناوين الصغيرة
  //? (هلو-البحث هنت)
  headlineSmall: TextStyle(
    fontSize: FontSizeManager.fs18,
    fontWeight: FontWeight.w400,
    color: AppColorManager.grey,
  ),

  //! العناصر المميزة بحجم كبير
  //? (نيكست-كاتيغوري تاغ-يوزر نيم بالدراور-)
  displayLarge: TextStyle(
    fontSize: FontSizeManager.fs20,
    fontWeight: FontWeight.bold,
    color: AppColorManager.white,
  ),

  //! العناصر المميزة بحجم متوسط
  //? (اسم المنتج بالكونتينر-سعر كونتينر-فيومور اوفر)
  displayMedium: TextStyle(
    fontSize: FontSizeManager.fs18,
    fontWeight: FontWeight.w600,
    color: AppColorManager.white,
  ),

  //! العناصر المميزة بحجم صغير
  //? (اسم كاتيغوري -وساب- رقم التقييم كونتينرين -وبالبرودكت)
  displaySmall: TextStyle(
    fontSize: FontSizeManager.fs16,
    color: AppColorManager.white,
    fontWeight: FontWeight.w400,
  ),

  //! النصوص الأساسية بحجم كبير
  //? (ر-السعر بالبرودكت-الوصف بالهوم للكونتبنرات فوقن -اسم المنتج بالبرودكت)
  bodyLarge: TextStyle(
    fontSize: FontSizeManager.fs20,
    fontWeight: FontWeight.w800,
    color: AppColorManager.navyBlue,
  ),

  //! النصوص الأساسية بحجم صغير
  //? ( فيو اول-برودكت كونتينرين دسكربشن)
  bodySmall: TextStyle(
    fontSize: FontSizeManager.fs16,
    fontWeight: FontWeight.w400,
    color: AppColorManager.grey,
  ),
);

//! App Dark Theme
ThemeData darkTheme() {
  return ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColorManager.background,
    ),
    brightness: Brightness.dark,
    primaryColorLight: AppColorManager.navyLightBlue,
    scaffoldBackgroundColor: AppColorManager.background,
    splashColor: AppColorManager.background,
    primaryColor: AppColorManager.navyLightBlue,
    textTheme: appTextTheme,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColorManager.navyLightBlue,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColorManager.navyLightBlue,
      foregroundColor: AppColorManager.navyLightBlue,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorManager.navyLightBlue,
      hintStyle: TextStyle(
        color: AppColorManager.white,
        fontSize: FontSizeManager.fs16,
        fontWeight: FontWeight.normal,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadiusManager.r5),
        borderSide: const BorderSide(
          color: AppColorManager.navyLightBlue,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadiusManager.r5),
        borderSide: const BorderSide(
          color: AppColorManager.navyLightBlue,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadiusManager.r3),
        borderSide: const BorderSide(color: AppColorManager.grey),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppWidthManager.w16,
        vertical: AppHeightManager.h1point5,
      ),
      floatingLabelStyle: const TextStyle(
        color: AppColorManager.navyLightBlue,
      ),
      iconColor: AppColorManager.navyLightBlue,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColorManager.navyLightBlue),
        borderRadius: BorderRadius.circular(AppRadiusManager.r3),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(),
        borderRadius: BorderRadius.circular(AppRadiusManager.r3),
      ),
    ),
    tabBarTheme: TabBarTheme(
      indicator: BoxDecoration(
        color: AppColorManager.navyLightBlue,
        borderRadius: BorderRadius.circular(AppRadiusManager.r5),
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColorManager.navyLightBlue,
      secondary: AppColorManager.navyLightBlue,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColorManager.yellow,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}

//! App Light Theme
ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColorManager.white,
    ),
    brightness: Brightness.light,
    primaryColorLight: AppColorManager.navyLightBlue,
    scaffoldBackgroundColor: AppColorManager.white,
    splashColor: AppColorManager.white,
    primaryColor: AppColorManager.whiteBlue,
    textTheme: appTextTheme,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColorManager.navyLightBlue,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColorManager.whiteBlue,
      foregroundColor: AppColorManager.whiteBlue,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorManager.whiteBlue,
      hintStyle: TextStyle(
        color: AppColorManager.navyLightBlue,
        fontSize: FontSizeManager.fs16,
        fontWeight: FontWeight.normal,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadiusManager.r5),
        borderSide: const BorderSide(
          color: AppColorManager.navyLightBlue,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadiusManager.r5),
        borderSide: const BorderSide(
          color: AppColorManager.grey,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadiusManager.r3),
        borderSide: const BorderSide(color: AppColorManager.grey),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppWidthManager.w16,
        vertical: AppHeightManager.h1point5,
      ),
      floatingLabelStyle: const TextStyle(
        color: AppColorManager.navyLightBlue,
      ),
      iconColor: AppColorManager.navyBlue,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColorManager.grey),
        borderRadius: BorderRadius.circular(AppRadiusManager.r3),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(),
        borderRadius: BorderRadius.circular(AppRadiusManager.r3),
      ),
    ),
    tabBarTheme: TabBarTheme(
      indicator: BoxDecoration(
        color: AppColorManager.navyLightBlue,
        borderRadius: BorderRadius.circular(AppRadiusManager.r5),
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColorManager.navyBlue,
      secondary: AppColorManager.navyLightBlue,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColorManager.whiteBlue,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
