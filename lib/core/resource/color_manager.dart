import 'package:flutter/material.dart';

abstract class AppColorManager {
  static const Color black = Color(0xff171717);

  static const Color grayLightBlue = Color.fromARGB(255, 117, 134, 148);
  static const Color navyLightBlue = Color(0xFF3A4853);

  static const Color navyBlue = Color(0xFF102333);
  static const Color background = Color.fromARGB(255, 16, 35, 51);

  static const Color grey = Color(0xff8e8e93);
  static const Color green = Color(0xff34c759);
  static const Color lightGray = Color.fromARGB(202, 142, 142, 147);
  static const Color orange = Color(0xffff9500);
  static const Color yellow = Color.fromARGB(255, 230, 185, 21);
  static const Color lightGrey = Color.fromARGB(255, 159, 158, 167);
  static const Color darkOrange2 = Color(0xffec1c24);

  static const Color red = Color(0xffEC1C24);
  static const Color white = Color(0xffffffff);
  static const Color error = Color.fromARGB(255, 122, 93, 92);
  static const Color whiteBlue = Color.fromARGB(255, 222, 222, 235);

  static const Color shimmerHighlightColor = Color(0xffd9d9d9);
  static const Color shimmerBaseColor = Color(0xffe0e0e0);

  static const Color textAppColor = Color(0xff171717);

  static Color lightGreyOpacity6 = const Color(0xffe5e5ea).withOpacity(0.6);
  static Color orangeShadow = orange.withOpacity(0.1);
  static Color greyShadowOpacity1 = const Color(0xff828282).withOpacity(0.1);
  static Color greenShadow = const Color(0xff34c759).withOpacity(0.1);

  static Color blackShadow = const Color(0xff171717).withOpacity(0.4);

  static const Color shadow = Color.fromARGB(28, 130, 130, 130);

  static const Color hint = Color(0xffc7c7cc);

  static const Color blue = Color(0xff32ADE6);

  static const Color dotGrey = Color(0xffE5E5EA);
}

abstract class AppGradientManager {
  static const Gradient orangeTopDownGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFEC1C24), Color(0xffec1c24), Color(0xfff92c0b)],
  );
  static Gradient greyDownTopGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      const Color(0xfffcfcfc),
      const Color(0xfffcfcfc).withOpacity(0.5),
      const Color(0xfffcfcfc).withOpacity(1),
    ],
  );
}
