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
    final theme = Theme.of(context);
    final isDarkMode = themeNotifier?.value == ThemeMode.dark;

    return Semantics(
      label: 'تفاصيل المنتَج الرائج: ${product.name}',
      child: Padding(
        padding: EdgeInsets.only(bottom: AppHeightManager.h2),
        child: Row(
          children: [
            Expanded(
              child: _buildProductContainer(context, theme, isDarkMode),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductContainer(
      BuildContext context, ThemeData theme, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadiusManager.r5),
        child: DecoratedContainer(
          color: isDarkMode
              ? AppColorManager.navyLightBlue
              : AppColorManager.whiteBlue,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppWidthManager.w1Point5,
              vertical: AppHeightManager.h02,
            ),
            child: Row(
              children: [
                _buildProductImage(context),
                SizedBox(width: AppWidthManager.w3Point5),
                _buildProductDetails(theme, isDarkMode),
                _buildProductRatingAndButton(theme, isDarkMode),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage(BuildContext context) {
    return Semantics(
      label: 'صورة المنتَج ${product.name}',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadiusManager.r5),
        child: SizedBox(
          width: AppWidthManager.w30,
          height: AppHeightManager.h11,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                "/ProductInfo",
                arguments: product,
              );
            },
            child: Hero(
              tag: 'product-image-trend${product.id}',
              child: Image.network(
                '${Config.imageUrl}/${product.image}',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetails(ThemeData theme, bool isDarkMode) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            label: 'اسم المنتَج',
            child: AppTextWidget(
              text: product.name,
              style: theme.textTheme.displayMedium?.copyWith(
                color: isDarkMode
                    ? AppColorManager.white
                    : AppColorManager.navyBlue,
              ),
            ),
          ),
          Semantics(
            label: 'وصف المنتَج',
            child: AppTextWidget(
              text: product.desc,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDarkMode
                    ? AppColorManager.grey
                    : AppColorManager.navyBlue,
              ),
            ),
          ),
          Semantics(
            label: 'سعر المنتَج',
            child: PriceText(
              price: product.price,
              priceStyle: theme.textTheme.displayMedium?.copyWith(
                color: isDarkMode
                    ? AppColorManager.white
                    : AppColorManager.navyBlue,
              ),
              style: theme.textTheme.displayMedium?.copyWith(
                color: isDarkMode
                    ? AppColorManager.white
                    : AppColorManager.navyBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductRatingAndButton(ThemeData theme, bool isDarkMode) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Semantics(
          label: 'تقييم المنتَج ${product.name} بنجمة',
          child: Padding(
            padding: EdgeInsets.only(
              top: AppHeightManager.h2,
              right: AppWidthManager.w3,
            ),
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
                    text: (product.rate != null
                        ? product.rate!.toStringAsFixed(1)
                        : '0.0'),
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: isDarkMode
                          ? AppColorManager.white
                          : AppColorManager.navyBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Semantics(
          label: 'زر إضافة المنتَج إلى السلة',
          child: CartButton(product: product),
        ),
      ],
    );
  }
}
