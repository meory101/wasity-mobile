import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wasity/core/theme/app_theme.dart';
import 'package:wasity/features/pages/home/widgets/button/button_navbar.dart';
import 'package:wasity/features/pages/cart/screen/cart.dart';
import 'package:wasity/features/pages/category/screens/Products_by_sub_category.dart';
import 'package:wasity/features/pages/home/screens/new_arrivais.dart';
import 'package:wasity/features/pages/profile/screens/saved_address.dart';
import 'package:wasity/features/pages/profile/screens/edit_profile.dart';
import 'package:wasity/features/pages/home/screens/home_screen.dart';
import 'package:wasity/features/pages/auth/screens/phone.dart';
import 'package:wasity/features/pages/home/screens/product_info.dart';
import 'package:wasity/features/pages/category/screens/all_category.dart';
import 'package:wasity/features/pages/profile/screens/profile_info.dart';
import 'package:wasity/features/pages/category/screens/sub_category_products.dart';
import 'package:wasity/features/pages/auth/screens/otp.dart';
import 'package:wasity/features/pages/home/screens/trending_product.dart';

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
            initialRoute: "/ButtonNavbar",
            routes: {
              "/AllCategory": (context) =>
                  AllCategory(themeNotifier: themeNotifier),
              "/Cart": (context) => Cart(themeNotifier: themeNotifier),
              "/SubCategoryProducts": (context) =>
                  SubCategoryProducts(themeNotifier: themeNotifier),
              "/Otp": (context) =>
                  Otp(otpCode: "", themeNotifier: themeNotifier),
              "/Phone": (context) => Phone(themeNotifier: themeNotifier),
              "/EditProfile": (context) =>
                  EditProfile(themeNotifier: themeNotifier),
              "/ProfileInfo": (context) =>
                  ProfileInfo(themeNotifier: themeNotifier),
              "/ButtonNavbar": (context) =>
                  ButtonNavbar(themeNotifier: themeNotifier),
              "/HomeScreen": (context) =>
                  HomeScreen(themeNotifier: themeNotifier),
              "/NewArrivais": (context) =>
                  NewArrivais(themeNotifier: themeNotifier),
              "/ProductInfo": (context) => ProductInfo(
                    themeNotifier: themeNotifier,
                    productId: 0, 
                  ),
              "/TrendingProduct": (context) =>
                  TrendingProduct(themeNotifier: themeNotifier),
              "/SavedAddresses": (context) =>
                  SavedAddresses(themeNotifier: themeNotifier),
              "/ProductsBySubCategory": (context) => ProductsBySubCategory(
                  themeNotifier: themeNotifier, subCategoryId: 0),
            },
          );
        },
      );
    });
  }
}
