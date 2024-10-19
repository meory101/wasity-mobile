import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/text/price_text_widget.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:wasity/features/pages/cart/widgets/button/cart_button.dart';

class Productsbysubbranchcontainer extends StatelessWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;
  final Product product;

  const Productsbysubbranchcontainer({
    super.key,
    this.themeNotifier,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = themeNotifier?.value == ThemeMode.dark;

    return Padding(
      padding: EdgeInsets.only(bottom: AppHeightManager.h2),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadiusManager.r5),
                child: Container(
                  width: AppWidthManager.w42,
                  color: isDarkMode
                      ? AppColorManager.navyLightBlue
                      : AppColorManager.whiteBlue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: AppHeightManager.h2,
                          bottom: AppHeightManager.h02,
                          left: AppWidthManager.w3Point5,
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppRadiusManager.r5),
                          child: SizedBox(
                            height: AppHeightManager.h19,
                            width: AppWidthManager.w35,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/ProductInfo",
                                  arguments: product,
                                );
                              },
                              child: Image.network(
                                '${Config.imageUrl}/${product.image}',
                                fit: BoxFit.fill,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Image.asset(
                                      'assets/images/placeholder.png');
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: AppHeightManager.h1,
                          left: AppWidthManager.w3,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: product.name,
                              style: theme.textTheme.displayMedium?.copyWith(
                                color: isDarkMode
                                    ? AppColorManager.white
                                    : AppColorManager.navyBlue,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          AppTextWidget(
                                            text: product.desc.isNotEmpty
                                                ? product.desc
                                                : "No description available",
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                              color: isDarkMode
                                                  ? AppColorManager.grey
                                                  : AppColorManager.navyBlue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppHeightManager.h05,
                            ),
                            Row(
                              children: [
                                // Product Price
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PriceText(
                                      price: product.price,
                                      style: theme.textTheme.displaySmall
                                          ?.copyWith(
                                        color: isDarkMode
                                            ? AppColorManager.white
                                            : AppColorManager.navyBlue,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: AppWidthManager.w4),
                                // Product Rating
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: AppWidthManager.w32,
                top: AppHeightManager.h27,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      AppIconManager.star,
                      colorFilter: const ColorFilter.mode(
                        AppColorManager.yellow,
                        BlendMode.srcIn,
                      ),
                      width: AppWidthManager.w12,
                      height: AppHeightManager.h2point2,
                    ),
                    SizedBox(width: AppWidthManager.w1),
                    AppTextWidget(
                      text: (product.rate != null
                          ? product.rate!.toStringAsFixed(1)
                          : '0.0'),
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: themeNotifier!.value == ThemeMode.dark
                            ? AppColorManager.white
                            : AppColorManager.navyBlue,
                      ),
                    ),
                  ],
                ),
              ),
              // Cart Button
              Positioned(
                left: AppWidthManager.w29,
                top: AppHeightManager.h17,
                child: CartButton(
                  product: product,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
