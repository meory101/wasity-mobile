import 'package:flutter/material.dart';
import 'package:wasity/core/helper/language_helper.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';

class WalletCard extends StatelessWidget {
  final double? balance;
  final int? points;

  const WalletCard({
    super.key,
    this.balance,
    this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RotatedBox(
          quarterTurns: LanguageHelper.checkIfLTR(context: context) ? 0 : 2,
          child: SvgPicture.asset(
            fit: BoxFit.fill,
            height: AppHeightManager.h30,
            AppIconManager.totals,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: AppWidthManager.w7point7,
            top: AppHeightManager.h1point8,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: AppHeightManager.h1),
            child: Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: AppWidthManager.w1, top: AppHeightManager.h2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: AppHeightManager.h2point5),
                          AppTextWidget(
                            text: "Points :",
                            fontWeight: FontWeight.w500,
                            fontSize: FontSizeManager.fs17,
                            color: AppColorManager.lightGreyOpacity6,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: AppWidthManager.w20),
                            child: AppTextWidget(
                              text: points != null
                                  ? points.toString()
                                  : "Loading...",
                              fontWeight: FontWeight.w700,
                              fontSize: FontSizeManager.fs17,
                              color: AppColorManager.white,
                            ),
                          ),
                          SizedBox(height: AppHeightManager.h1),
                          AppTextWidget(
                            text: "Balance :",
                            fontWeight: FontWeight.w700,
                            fontSize: FontSizeManager.fs18,
                            color: AppColorManager.lightGreyOpacity6,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: AppWidthManager.w25),
                            child: AppTextWidget(
                              text: balance != null
                                  ? balance.toString()
                                  : "Loading...",
                              fontWeight: FontWeight.w700,
                              fontSize: FontSizeManager.fs17,
                              color: AppColorManager.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: AppHeightManager.h3,
                          left: AppWidthManager.w27),
                      child: SizedBox(
                        height: AppHeightManager.h4,
                        width: AppWidthManager.w20,
                        child: Image.asset(AppImageManager.logo),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
