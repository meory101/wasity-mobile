import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class LanguageHelper {
  static bool checkIfLTR({required BuildContext context}) {
    return Directionality.of(context) == TextDirection.ltr;
  }

}
