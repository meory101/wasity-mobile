import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wasity/features/home/screens/home_screen.dart';
import 'package:wasity/features/home/screens/new_arrivais.dart';
import 'package:wasity/features/home/screens/phone.dart';
import 'package:wasity/features/home/screens/sub_category.dart';
import 'package:wasity/features/home/screens/sub_category_products.dart';
import 'package:wasity/features/home/screens/trending_product.dart';
import 'package:wasity/features/home/screens/otp.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        initialRoute: "/Phone",
        routes: {
          "/SubcategoryPage": (context) => SubcategoryPage(),
          "/SubCategoryProducts": (context) => SubCategoryProducts(),
          "/Otp": (context) => Otp(),
          "/Phone": (context) => Phone(),
          "/HomeScreen": (context) => HomeScreen(),
          "/TrendingProduct": (context) => TrendingProduct(),
          "/NewArrivais": (context) => NewArrivais(),
        },
      );
    });
  }
}
