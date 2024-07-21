import 'package:flutter/material.dart';
import 'app/app.dart';

void main() {
  final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

  runApp(App(themeNotifier: themeNotifier));
}
