import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wasity/core/theme/app_theme.dart';
import 'package:wasity/features/home/screens/home_screen.dart';
import 'package:wasity/features/home/screens/new_arrivais.dart';
import 'package:wasity/features/home/screens/phone.dart';
import 'package:wasity/features/home/screens/product_info.dart';
import 'package:wasity/features/home/screens/sub_category.dart';
import 'package:wasity/features/home/screens/sub_category_products.dart';
// import 'package:wasity/features/home/screens/trending_product.dart';
import 'package:wasity/features/home/screens/otp.dart';
import 'package:wasity/features/home/screens/trending_product.dart';

ThemeData themeNotifier = ThemeData();

class App extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const App({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (context, themeMode, child) {
          return MaterialApp(
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: themeNotifier.value,
            debugShowCheckedModeBanner: false,
            home: HomeScreen(themeNotifier: themeNotifier),
            initialRoute: "/Phone",
            routes: {
              "/SubcategoryPage": (context) => SubcategoryPage(
                    themeNotifier: themeNotifier,
                  ),
              "/SubCategoryProducts": (context) => SubCategoryProducts(
                    themeNotifier: themeNotifier,
                  ),
              "/Otp": (context) => Otp(themeNotifier: themeNotifier),
              "/Phone": (context) => Phone(themeNotifier: themeNotifier),
              "/HomeScreen": (context) =>
                  HomeScreen(themeNotifier: themeNotifier),
              "/NewArrivais": (context) =>
                  NewArrivais(themeNotifier: themeNotifier),
              "/ProductInfo": (context) =>
                  ProductInfo(themeNotifier: themeNotifier),
              "/TrendingProduct": (context) =>
                  TrendingProduct(themeNotifier: themeNotifier),
            },
          );
        },
      );
    });
  }
}
