import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/text/price_text_widget.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:wasity/features/pages/cart/widgets/button/cart_button.dart';
import 'package:wasity/features/pages/home/screens/product_info.dart';

class ProductsbysubcategoryContainer extends StatelessWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;
  final Product product;
  const ProductsbysubcategoryContainer(
      {super.key, this.themeNotifier, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = themeNotifier?.value == ThemeMode.dark;

    return Padding(
      padding: EdgeInsets.only(bottom: AppHeightManager.h5),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadiusManager.r5),
                child: Container(
                  width: AppWidthManager.w42,
                  height: AppHeightManager.h36,
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
                                  MaterialPageRoute(
                                    builder: (context) => ProductInfo(
                                      themeNotifier: themeNotifier,
                                      productId: product.id,
                                    ),
                                  ) as String,
                                );
                              },
                              child: Image.network(
                                'http://127.0.0.1:8000/storage/${product.image}',
                                fit: BoxFit.fill,
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
                            // AppTextWidget(
                            //   text: product.description ?? "No description",
                            //   style: theme.textTheme.bodySmall?.copyWith(
                            //     color: isDarkMode ? AppColorManager.grey : AppColorManager.navyBlue,
                            //   ),
                            // ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PriceText(
                                      price: product.price,
                                      style: theme.textTheme.displayMedium
                                          ?.copyWith(
                                        color: isDarkMode
                                            ? AppColorManager.white
                                            : AppColorManager.navyBlue,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: AppWidthManager.w4),
                                Column(
                                  children: [
                                    Row(
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
                                        // AppTextWidget(
                                        //   text: product.rating.toString(),
                                        //   style: theme.textTheme.displaySmall?.copyWith(
                                        //     color: isDarkMode ? AppColorManager.white : AppColorManager.navyBlue,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
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
                left: AppWidthManager.w29,
                top: AppHeightManager.h17,
                child: const CartButton(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
