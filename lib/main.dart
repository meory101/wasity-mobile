import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasity/core/storage/shared/shared_pref.dart';
import 'package:wasity/app/app.dart';
import 'package:provider/provider.dart';
import 'package:wasity/features/pages/cart/provider/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  AppSharedPreferences.init(prefs);

  final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: Wasity(themeNotifier: themeNotifier),
    ),
  );
}
