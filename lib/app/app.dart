import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wasity/core/theme/app_theme.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:wasity/features/pages/branch/main_branch.dart';
import 'package:wasity/features/pages/home/screens/trending_product.dart';
import 'package:wasity/features/pages/home/widgets/button/button_navbar.dart';
import 'package:wasity/features/pages/cart/screen/cart.dart';
import 'package:wasity/features/pages/category/screens/Products_by_sub_category.dart';
import 'package:wasity/features/pages/home/screens/new_arrivais.dart';
import 'package:wasity/features/pages/branch/sub_branch.dart';
import 'package:wasity/features/pages/orders/screens/map.dart';
import 'package:wasity/features/pages/orders/screens/order_history.dart';
import 'package:wasity/features/pages/orders/screens/saved_address.dart';
import 'package:wasity/features/pages/profile/screens/edit_profile.dart';
import 'package:wasity/features/pages/home/screens/home_screen.dart';
import 'package:wasity/features/pages/auth/screens/phone.dart';
import 'package:wasity/features/pages/home/screens/product_info.dart';
import 'package:wasity/features/pages/category/screens/all_category.dart';
import 'package:wasity/features/pages/profile/screens/profile_info.dart';
import 'package:wasity/features/pages/category/screens/sub_category_products.dart';
import 'package:wasity/features/pages/auth/screens/otp.dart';

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
            initialRoute: "/Cart",
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case "/AllCategory":
                  return MaterialPageRoute(
                    builder: (context) =>
                        AllCategory(themeNotifier: themeNotifier),
                  );
                case "/Cart":
                  return MaterialPageRoute(
                    builder: (context) => Cart(themeNotifier: themeNotifier),
                  );
                case "/SubCategoryProducts":
                  final arguments = settings.arguments as Map<String, dynamic>;
                  final subCategoryId = arguments['id'] as int;
                  final subCategoryName = arguments['name'] as String;
                  return MaterialPageRoute(
                    builder: (context) => SubCategoryProducts(
                      themeNotifier: themeNotifier,
                      subCategoryId: subCategoryId,
                      subCategoryName: subCategoryName,
                    ),
                  );
                case "/Otp":
                  return MaterialPageRoute(
                    builder: (context) => Otp(
                      otpCode: "",
                      themeNotifier: themeNotifier,
                      clientId: '',
                    ),
                  );

                case "/Phone":
                  return MaterialPageRoute(
                    builder: (context) => Phone(themeNotifier: themeNotifier),
                  );
                case "/EditProfile":
                  return MaterialPageRoute(
                    builder: (context) =>
                        EditProfile(themeNotifier: themeNotifier),
                  );
                case "/ProfileInfo":
                  return MaterialPageRoute(
                    builder: (context) =>
                        ProfileInfo(themeNotifier: themeNotifier),
                  );
                case "/ButtonNavbar":
                  return MaterialPageRoute(
                    builder: (context) =>
                        ButtonNavbar(themeNotifier: themeNotifier),
                  );
                case "/HomeScreen":
                  final args = settings.arguments as Map<String, dynamic>;
                  return MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      themeNotifier: args['themeNotifier'],
                      product: args['product'],
                    ),
                  );

                case "/NewArrivais":
                  return MaterialPageRoute(
                    builder: (context) =>
                        NewArrivais(themeNotifier: themeNotifier),
                  );
                case "/ProductInfo":
                  final product = settings.arguments as Product;
                  return MaterialPageRoute(
                    builder: (context) => ProductInfo(
                      themeNotifier: themeNotifier,
                      product: product, subBranchId: 0,
                    ),
                  );
                case "/TrendingProduct":
                  return MaterialPageRoute(
                    builder: (context) => TrendingProduct(
                      themeNotifier: themeNotifier,
                    ),
                  );
                case "/GMap":
                  return MaterialPageRoute(
                    builder: (context) => const GMap(),
                  );
                case "/OrderHistory":
                  return MaterialPageRoute(
                    builder: (context) =>
                        OrderHistory(themeNotifier: themeNotifier),
                  );
                case "/SavedAddresses":
                  return MaterialPageRoute(
                    builder: (context) =>
                        SavedAddresses(themeNotifier: themeNotifier),
                  );
                case "/MainBranch":
                  return MaterialPageRoute(
                    builder: (context) =>
                        MainBranch(themeNotifier: themeNotifier),
                  );
                case "/SubBranchPage":
                  final mainBranchId = settings.arguments as int;
                  return MaterialPageRoute(
                    builder: (context) => SubBranchPage(
                      themeNotifier: themeNotifier,
                      mainBranchId: mainBranchId,
                    ),
                  );
                case "/ProductsBySubCategory":
                  final subCategoryId = settings.arguments as int;
                  return MaterialPageRoute(
                    builder: (context) => ProductsBySubCategory(
                      themeNotifier: themeNotifier,
                      subCategoryId: subCategoryId,
                      mainCategoryId: 0,
                    ),
                  );
                default:
                  return null;
              }
            },
          );
        },
      );
    });
  }
}
