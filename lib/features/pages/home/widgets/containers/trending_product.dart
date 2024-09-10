import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/text/price_text_widget.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:wasity/features/pages/cart/widgets/button/cart_button.dart';

class TrendingProductContainer extends StatelessWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;
  final Product product;

  const TrendingProductContainer({
    super.key,
    this.themeNotifier,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: AppHeightManager.h2),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Main Container
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadiusManager.r5),
                  child: DecoratedContainer(
                    color: themeNotifier!.value == ThemeMode.dark
                        ? AppColorManager.navyLightBlue
                        : AppColorManager.whiteBlue,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppWidthManager.w1Point5,
                        vertical: AppHeightManager.h02,
                      ),
                      child: Row(
                        children: [
                          // Product image
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(AppRadiusManager.r5),
                            child: SizedBox(
                              width: AppWidthManager.w25,
                              height: AppHeightManager.h11,
                              child: InkWell(
                                child: Image.network(
                                  '${Config.imageUrl}/${product.image}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error);
                                  },
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    "/ProductInfo",
                                    arguments: product,
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: AppWidthManager.w3Point5),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product name
                                AppTextWidget(
                                  text: product.name,
                                  style:
                                      theme.textTheme.displayMedium?.copyWith(
                                    color:
                                        themeNotifier!.value == ThemeMode.dark
                                            ? AppColorManager.white
                                            : AppColorManager.navyBlue,
                                  ),
                                ),
                                // Product description
                                AppTextWidget(
                                  text: product.desc,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color:
                                        themeNotifier!.value == ThemeMode.dark
                                            ? AppColorManager.grey
                                            : AppColorManager.navyBlue,
                                  ),
                                ),
                                // Product Price
                                PriceText(
                                  price: product.price,
                                  priceStyle:
                                      theme.textTheme.displayMedium?.copyWith(
                                    color:
                                        themeNotifier!.value == ThemeMode.dark
                                            ? AppColorManager.white
                                            : AppColorManager.navyBlue,
                                  ),
                                  style:
                                      theme.textTheme.displayMedium?.copyWith(
                                    color:
                                        themeNotifier!.value == ThemeMode.dark
                                            ? AppColorManager.white
                                            : AppColorManager.navyBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Rating
                              Padding(
                                padding: EdgeInsets.only(
                                    top: AppHeightManager.h2,
                                    right: AppWidthManager.w3),
                                child: Row(
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
  text: (product.rate != null ? product.rate!.toStringAsFixed(1) : '0.0'),
  style: theme.textTheme.displaySmall?.copyWith(
    color: themeNotifier!.value == ThemeMode.dark
        ? AppColorManager.white
        : AppColorManager.navyBlue,
  ),
),

                                    ),
                                  ],
                                ),
                              ),
                               CartButton(product: product,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
