import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/button/app_button.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/text/price_text_widget.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:provider/provider.dart';
import 'package:wasity/features/pages/cart/provider/cart_provider.dart';
import 'package:wasity/features/pages/branch/products_by_sub_branchId.dart';

class ProductInfo extends StatefulWidget {
  final Product product;
  final int subBranchId;
  final ValueNotifier<ThemeMode>? themeNotifier;

  const ProductInfo({
    super.key,
    required this.product,
    this.themeNotifier,
    required this.subBranchId,
  });

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
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
                      child: Hero(
                        tag: 'product-image-trend${product.id}',
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
                                  fontWeight: FontWeight.bold)),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

//!Rating
  Future<void> _showRatingDialog(BuildContext context) async {
    double? ratingValue = 3.0;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rate Product'),
        content: RatingBar.builder(
          initialRating: ratingValue!,
          minRating: 1,
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            ratingValue = rating;
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await RateService.submitRating(ratingValue!, widget.product.id);
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
              setState(() {});
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
