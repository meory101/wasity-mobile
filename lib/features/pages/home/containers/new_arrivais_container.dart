import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/text/price_text_widget.dart';
import 'package:wasity/features/pages/cart/button/cart_button.dart';

class NewArrivalsContainer extends StatefulWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;

  // ignore: use_super_parameters
  const NewArrivalsContainer({Key? key, this.themeNotifier}) : super(key: key);

  @override
  State<NewArrivalsContainer> createState() => _NewArrivalsContainerState();
}

class _NewArrivalsContainerState extends State<NewArrivalsContainer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = widget.themeNotifier?.value == ThemeMode.dark;

    return Padding(
      padding: EdgeInsets.only(bottom: AppHeightManager.h5),
      child: Row(
        children: [
          //?  main container
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
                      // ?صورة المنتج
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
                                Navigator.pushNamed(context, "/ProductInfo");
                              },
                              child: Image.asset(
                                AppImageManager.productImage,
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
                            //? اسم المنتج
                            AppTextWidget(
                              text: "Product Name",
                              style: theme.textTheme.displayMedium?.copyWith(
                                color: isDarkMode
                                    ? AppColorManager.white
                                    : AppColorManager.navyBlue,
                              ),
                            ),

                            //? وصف المنتج
                            AppTextWidget(
                              text: "Product description",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: isDarkMode
                                    ? AppColorManager.grey
                                    : AppColorManager.navyBlue,
                              ),
                            ),

                            Row(
                              children: [
                                //? سعر المنتج
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PriceText(
                                      price: 123.45,
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

                                //? التقييم
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        //? أيقونة النجمة
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
                                        //? قيمة التقييم
                                        AppTextWidget(
                                          text: "4.2",
                                          style: theme.textTheme.displaySmall
                                              ?.copyWith(
                                            color: isDarkMode
                                                ? AppColorManager.white
                                                : AppColorManager.navyBlue,
                                          ),
                                        ),
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
