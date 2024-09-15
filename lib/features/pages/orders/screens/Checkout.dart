import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/button/app_button.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:wasity/features/pages/cart/provider/cart_provider.dart';
import 'package:wasity/features/pages/cart/widgets/cartItemsList/cart_list.dart';
import 'package:http/http.dart' as http;

class Checkout extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const Checkout({super.key, required this.themeNotifier});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  void _removeItem(Product product) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.removeFromCart(product);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: SecondAppbar(
        titleText: "Checkout",
        onBack: () => Navigator.pop(context),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppWidthManager.w5Point3,
            vertical: AppHeightManager.h2,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  AppTextWidget(
                    text: "Shipping Address",
                    style: theme.textTheme.displayLarge?.copyWith(
                      color: theme.brightness == Brightness.dark
                          ? AppColorManager.white
                          : AppColorManager.navyBlue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppHeightManager.h2),
              DecoratedContainer(
                height: AppHeightManager.h10,
                borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                color: theme.brightness == Brightness.dark
                    ? AppColorManager.navyBlue
                    : AppColorManager.whiteBlue,
                boxShadow: [
                  BoxShadow(
                    blurRadius: AppRadiusManager.r6,
                    color: AppColorManager.grey,
                  ),
                ],
                child: Padding(
                  padding: EdgeInsets.only(left: AppWidthManager.w8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(27),
                        child: Container(
                          height: AppHeightManager.h6,
                          width: AppWidthManager.w13point5,
                          color: theme.brightness == Brightness.dark
                              ? AppColorManager.navyLightBlue
                              : AppColorManager.lightGrey,
                          child: Icon(
                            Icons.location_on_rounded,
                            size: AppHeightManager.h3,
                            color: theme.brightness == Brightness.dark
                                ? AppColorManager.white
                                : AppColorManager.navyLightBlue,
                          ),
                        ),
                      ),
                      SizedBox(width: AppWidthManager.w8),
                      AppTextWidget(
                        text: "Your Location",
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: theme.brightness == Brightness.dark
                              ? AppColorManager.white
                              : AppColorManager.navyBlue,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/SavedAddresses'),
                        icon: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppHeightManager.h2),
              const Divider(color: AppColorManager.navyLightBlue),
              SizedBox(height: AppHeightManager.h2),
              //?cart list
              CartItemsWidget(
                themeNotifier: widget.themeNotifier,
                onRemove: _removeItem,
              ),
              const Divider(color: AppColorManager.navyLightBlue),
              SizedBox(height: AppHeightManager.h2),
              Row(
                children: [
                  AppTextWidget(
                    text: "Choose Shipping",
                    style: theme.textTheme.displayLarge?.copyWith(
                      color: theme.brightness == Brightness.dark
                          ? AppColorManager.white
                          : AppColorManager.navyBlue,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  DecoratedContainer(
                    color: AppColorManager.green,
                    height: AppHeightManager.h50,
                    boxShadow: const [
                      BoxShadow(color: Color.fromARGB(255, 139, 15, 11))
                    ],
                  ),
                ],
              ),

              AppElevatedButton(
                text: "Place Order",
                color: AppColorManager.yellow,
                onPressed: () {
                  placeOrder();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

placeOrder() async {
  final response =
      await http.post(Uri.parse(Config.getFullUrl('addOrder')), body: {
    'items': cartItemsApi,
    
  });

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((item) => Product.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load new items');
  }
}
// pay type 
// address id
//client id
// delivery type