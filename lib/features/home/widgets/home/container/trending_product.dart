import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/text/price_text_widget.dart';
import 'package:wasity/features/home/widgets/home/button/cart_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrendingProductContainer extends StatelessWidget {
  TrendingProductContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppHeightManager.h2),
      child: Row(
        children: [
          Stack(
            children: [
              //?Main Container
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadiusManager.r5),
                child: DecoratedContainer(
                  color: AppColorManager.navyLightBlue,
                  width: AppWidthManager.w89,
                  height: AppHeightManager.h15point7,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: AppWidthManager.w3Point5,
                        top: AppHeightManager.h02,
                        bottom: AppHeightManager.h08),
                    child: Row(
                      children: [
                        //? Product image
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppRadiusManager.r5),
                          child: DecoratedContainer(
                            color: AppColorManager.grayLightBlue,
                            width: AppWidthManager.w25,
                            height: AppHeightManager.h11,
                            child: Image.asset(
                              AppImageManager.productImage,
                              fit: BoxFit.cover,
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
                              //?Product name
                              AppTextWidget(
                                fontWeight: FontWeight.w400,
                                text: "Product Name",
                                fontSize: FontSizeManager.fs19,
                              ),

                              //? Product Description
                              AppTextWidget(
                                color: AppColorManager.grey,
                                fontWeight: FontWeight.w400,
                                text: "Product description",
                                fontSize: FontSizeManager.fs17,
                              ),
                              //?Product Price
                              PriceText(
                                price: 123.45,
                                priceStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColorManager.white,
                                ),
                                style: TextStyle(),
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
                              //?Rating
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
                                      fontSize: FontSizeManager.fs16,
                                      fontWeight: FontWeight.w400,
                                      color: AppColorManager.white,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                    top: AppHeightManager.h2,
                                  ),
                                  child: CartButton()),
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
