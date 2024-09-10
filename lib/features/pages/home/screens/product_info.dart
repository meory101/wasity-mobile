import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/storage/shared/shared_pref.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/button/app_button.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/text/price_text_widget.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:wasity/features/pages/branch/products_by_sub_branchId.dart';
import 'package:wasity/features/pages/cart/provider/cart_provider.dart';

// ignore: must_be_immutable
class ProductInfo extends StatefulWidget {
  Product product;
  final int subBranchId;

  final ValueNotifier<ThemeMode>? themeNotifier;

  ProductInfo(
      {super.key,
      required this.product,
      this.themeNotifier,
      required this.subBranchId});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  Future<void> _submitRating(double value) async {
    // Retrieve client ID from shared preferences
    String clientId = AppSharedPreferences.getClientId();

    if (clientId.isEmpty) {
      if (kDebugMode) {
        print('Error: Client ID is null or empty');
      }
      return;
    }

    int? clientIdParsed = int.tryParse(clientId);
    if (clientIdParsed == null) {
      if (kDebugMode) {
        print('Error: Invalid Client ID');
      }
      return;
    }

    // Prepare data
    Map<String, dynamic> data = {
      "value": value.toStringAsFixed(1),
      "product_id": widget.product.id,
      "client_id": clientIdParsed,
    };

    try {
      if (kDebugMode) {
        print(clientId);
      }
      if (kDebugMode) {
        print(
          "c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000lientId");
      }

      final response = await http.post(
        Uri.parse('http://192.168.1.103:8000/api/rateProduct'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => ProductInfo(
              product: widget.product,
              themeNotifier: widget.themeNotifier,
              subBranchId: 0,
            ),
          ),
        );
      } else {
        if (kDebugMode) {
          print(
            'Error submitting rating: ${response.statusCode} - ${response.body}');
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;
    final Color textColor =
        isDarkMode ? Colors.white : AppColorManager.navyLightBlue;

    final product = widget.product;
    final double? rating = product.rate;
    final String subBranchName = product.subBranch.name;
    final String brandImageUrl = '${Config.imageUrl}/${product.brand.image}';
    final String productImageUrl = '${Config.imageUrl}/${product.image}';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SecondAppbar(
        titleText: product.name,
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: AppHeightManager.h2,
                right: AppWidthManager.w4,
                left: AppWidthManager.w4,
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadiusManager.r16),
                    child: DecoratedContainer(
                      borderRadius: BorderRadius.circular(AppRadiusManager.r15),
                      height: AppHeightManager.h30,
                      width: AppWidthManager.w80,
                      child: Image.network(
                        productImageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset('assets/images/placeholder.png');
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: AppHeightManager.h6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextWidget(
                        text: product.name,
                        style: theme.textTheme.displayLarge
                            ?.copyWith(color: textColor),
                      ),
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(AppRadiusManager.r5),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductsBySubBranchid(
                                      subBranchId: product.subBranch.id,
                                      themeNotifier: widget.themeNotifier,
                                    ),
                                  ),
                                );
                              },
                              child: DecoratedContainer(
                                width: AppWidthManager.w25,
                                color: AppColorManager.yellow,
                                child: Center(
                                  child: AppTextWidget(
                                    text: subBranchName,
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: AppWidthManager.w2),
                  Row(
                    children: [
                      AppTextWidget(
                        text: rating?.toStringAsFixed(1) ?? '0.0',
                        style: theme.textTheme.displaySmall
                            ?.copyWith(color: textColor),
                      ),
                      RatingBarIndicator(
                        rating: rating ?? 0,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: AppColorManager.yellow,
                        ),
                        itemCount: 5,
                        itemSize: AppRadiusManager.r15,
                        direction: Axis.horizontal,
                        unratedColor: AppColorManager.white,
                      ),
                      SizedBox(width: AppWidthManager.w2),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: AppWidthManager.w1,
                      right: AppWidthManager.w5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextWidget(
                          text: product.desc,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: textColor),
                        ),
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppRadiusManager.r16),
                          child: DecoratedContainer(
                            borderRadius:
                                BorderRadius.circular(AppRadiusManager.r15),
                            height: AppHeightManager.h7,
                            width: AppWidthManager.w15,
                            child: Image.network(
                              brandImageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Image.asset(
                                    'assets/images/placeholder.png');
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppWidthManager.w5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PriceText(
                        price: product.price,
                        priceStyle: theme.textTheme.displayLarge
                            ?.copyWith(color: textColor),
                        style: theme.textTheme.displayLarge
                            ?.copyWith(color: textColor),
                      ),
                      SizedBox(
                        width: AppWidthManager.w30point8,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppRadiusManager.r5)),
                            backgroundColor: AppColorManager.lightGray,
                          ),
                          onPressed: () => _showRatingDialog(context),
                          child: const Text(
                            'Rate Product',
                            style: TextStyle(color: AppColorManager.whiteBlue),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer<CartProvider>(
                builder: (context, cartProvider, child) => DecoratedContainer(
                  height: AppHeightManager.h12,
                  color: AppColorManager.navyLightBlue,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppHeightManager.h2point5,
                      horizontal: AppWidthManager.w6,
                    ),
                    child: AppElevatedButton(
                      text: "Add to cart",
                      color: AppColorManager.white,
                      onPressed: () {
                        cartProvider.addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: AppTextWidget(
                                  text: 'Product added to cart!',
                                  color: AppColorManager.navyBlue,
                                  fontSize: 18)),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _showRatingDialog(BuildContext context) {
    double selectedRating = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColorManager.lightGray,
          title: AppTextWidget(
              text: 'Rate Product',
              style: TextStyle(
                  fontSize: FontSizeManager.fs20,
                  color: AppColorManager.whiteBlue)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                unratedColor: AppColorManager.navyBlue,
                initialRating: widget.product.rate ?? 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: AppColorManager.yellow,
                ),
                onRatingUpdate: (newRating) {
                  selectedRating = double.parse(newRating.toStringAsFixed(1));
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColorManager.whiteBlue),
              ),
            ),
            TextButton(
              onPressed: () {
                _submitRating(selectedRating);
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(color: AppColorManager.whiteBlue),
              ),
            ),
          ],
        );
      },
    );
  }
}
