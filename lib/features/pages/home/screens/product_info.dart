import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/text/price_text_widget.dart';

class ProductInfo extends StatefulWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;

  const ProductInfo({super.key, this.themeNotifier});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  final double _rating = 3.5;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;
    final Color textColor =
        isDarkMode ? Colors.white : AppColorManager.navyLightBlue;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SecondAppbar(
        titleText: "Product Info",
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: AppHeightManager.h5,
              right: AppWidthManager.w6,
              left: AppWidthManager.w6),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadiusManager.r16),
                child: DecoratedContainer(
                  borderRadius: BorderRadius.circular(AppRadiusManager.r15),
                  height: AppHeightManager.h35,
                  width: AppWidthManager.w110,
                  child: Image.asset(
                    AppImageManager.productImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: AppHeightManager.h6),
              Row(
                children: [
                  AppTextWidget(
                    text: "Product Name",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: textColor),
                  ),
                  SizedBox(width: AppWidthManager.w25),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadiusManager.r5),
                    child: DecoratedContainer(
                      width: AppWidthManager.w20,
                      color: AppColorManager.yellow,
                      child: Center(
                        child: AppTextWidget(
                          text: "Food",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppWidthManager.w2),
              Row(
                children: [
                  AppTextWidget(
                    text: _rating.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: textColor),
                  ),
                  RatingBarIndicator(
                    rating: _rating,
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
              SizedBox(height: AppWidthManager.w5),
              Row(
                children: [
                  PriceText(
                    price: 12000,
                    priceStyle: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: textColor),
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: textColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
