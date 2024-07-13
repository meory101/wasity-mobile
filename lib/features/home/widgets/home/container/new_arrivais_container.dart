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
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasity/features/home/widgets/home/button/cart_button.dart';

class NewArrivaisContainer extends StatefulWidget {
  const NewArrivaisContainer({super.key});

  @override
  State<NewArrivaisContainer> createState() => _NewArrivaisContainerState();
}

class _NewArrivaisContainerState extends State<NewArrivaisContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppHeightManager.h3),
      child: Row(
        children: [
          //?Main container
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadiusManager.r5),
                child: DecoratedContainer(
                  color: AppColorManager.navyLightBlue,
                  width: AppWidthManager.w42,
                  height: AppHeightManager.h36,
                  child: Column(
                    children: [
                      //? Product image
                      Padding(
                        padding: EdgeInsets.only(
                            top: AppHeightManager.h2,
                            bottom: AppHeightManager.h02),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppRadiusManager.r5),
                          child: SizedBox(
                            height: AppHeightManager.h19,
                            width: AppWidthManager.w35,
                            child: Image.asset(
                              AppImageManager.productImage,
                              fit: BoxFit.fill,
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
                            //?Product name
                            AppTextWidget(
                              fontWeight: FontWeight.w400,
                              text: "Product Name",
                              fontSize: FontSizeManager.fs18,
                            ),
                      
                            //? Product Description
                            AppTextWidget(
                              color: AppColorManager.grey,
                              fontWeight: FontWeight.w400,
                              text: "Product description",
                              fontSize: FontSizeManager.fs17,
                            ),
                      
                            Row(
                              children: [
                                //?Product Price
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PriceText(
                                      price: 123.45,
                                      priceStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColorManager.white,
                                      ),
                                      style: TextStyle(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: AppWidthManager.w4,
                                ),
                                //?Rating
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
                                          width: AppWidthManager.w7,
                                          height: AppHeightManager.h2,
                                        ),
                                        SizedBox(
                                          width: AppWidthManager.w7,
                                          child: Center(
                                            child: AppTextWidget(
                                              text: "4.2",
                                              fontSize: FontSizeManager.fs16,
                                              fontWeight: FontWeight.w400,
                                              color: AppColorManager.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
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
                  child: CartButton()),
            ],
          ),
        ],
      ),
    );
  }
}
