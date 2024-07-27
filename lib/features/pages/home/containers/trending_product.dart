import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/text/price_text_widget.dart';
import 'package:wasity/features/pages/cart/button/cart_button.dart';

class TrendingProductContainer extends StatelessWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;

  const TrendingProductContainer({super.key, this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: AppHeightManager.h2),
      child: Row(
        children: [
          Stack(
            children: [
              //? Main Container
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadiusManager.r5),
                child: DecoratedContainer(
                  color: themeNotifier!.value == ThemeMode.dark
                      ? AppColorManager.navyLightBlue
                      : AppColorManager.whiteBlue,
                  width: AppWidthManager.w89,
                  height: AppHeightManager.h15point7,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: AppWidthManager.w3Point5,
                        top: AppHeightManager.h02,
                        bottom: AppHeightManager.h08),
                    child: Row(
                      children: [
                        // ?Product image
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppRadiusManager.r5),
                          child: DecoratedContainer(
                            width: AppWidthManager.w25,
                            height: AppHeightManager.h11,
                            child: InkWell(
                              child: Image.asset(
                                AppImageManager.productImage,
                                fit: BoxFit.cover,
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/ProductInfo",
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: AppWidthManager.w3Point5,
                              top: AppHeightManager.h2point2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ?Product name
                              AppTextWidget(
                                text: "Product Name",
                                style: theme.textTheme.displayMedium?.copyWith(
                                  color: themeNotifier!.value == ThemeMode.dark
                                      ? AppColorManager.white
                                      : AppColorManager.navyBlue,
                                ),
                              ),

                              //? Product Description
                              AppTextWidget(
                                text: "Product description",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: themeNotifier!.value == ThemeMode.dark
                                      ? AppColorManager.grey
                                      : AppColorManager.navyBlue,
                                ),
                              ),
                              //? Product Price
                              PriceText(
                                price: 123.45,
                                priceStyle:
                                    theme.textTheme.displayMedium?.copyWith(
                                  color: themeNotifier!.value == ThemeMode.dark
                                      ? AppColorManager.white
                                      : AppColorManager.navyBlue,
                                ),
                                style: theme.textTheme.displayMedium?.copyWith(
                                  color: themeNotifier!.value == ThemeMode.dark
                                      ? AppColorManager.white
                                      : AppColorManager.navyBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: AppWidthManager.w7,
                              top: AppHeightManager.h1point5),
                          child: Column(
                            children: [
                              //? Rating
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
                                  SizedBox(
                                    child: AppTextWidget(
                                      text: "4.2",
                                      style: theme.textTheme.displaySmall
                                          ?.copyWith(
                                        color: themeNotifier!.value ==
                                                ThemeMode.dark
                                            ? AppColorManager.white
                                            : AppColorManager.navyBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                    top: AppHeightManager.h2,
                                  ),
                                  child: const CartButton()),
                            ],
                          ),
                        )
                      ],
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
}
