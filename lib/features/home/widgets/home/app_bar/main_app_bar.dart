import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/features/home/widgets/home/button/circular_icon_button.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeightManager.h12,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: AppWidthManager.w3Point8),
            child: CircularIconButton(
              buttonColor: AppColorManager.navyLightBlue,
              buttonIcon: SvgPicture.asset(
                colorFilter: const ColorFilter.mode(
                  AppColorManager.white,
                  BlendMode.srcIn,
                ),
                AppIconManager.list,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: AppWidthManager.w3),
            child: CircularIconButton(
                buttonIcon: Image.asset(AppImageManager.personalImage)),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: AppWidthManager.w4point7, right: AppWidthManager.w8),
                child: AppTextWidget(
                  text: "Hello",
                  fontSize: FontSizeManager.fs18,
                  fontWeight: FontWeight.bold,
                  color: AppColorManager.grey,
                ),
              ),
              AppTextWidget(
                text: "Ahmad!",
                height: AppHeightManager.h02,
                fontSize: FontSizeManager.fs20,
                fontWeight: FontWeight.bold,
                color: AppColorManager.white,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: AppWidthManager.w26,
            ),
            child: CircularIconButton(
              buttonColor: AppColorManager.navyLightBlue,
              buttonIcon: SvgPicture.asset(
                colorFilter: const ColorFilter.mode(
                  AppColorManager.white,
                  BlendMode.srcIn,
                ),
                AppIconManager.notification,
                // width: AppWidthManager.w1,
                // height: AppHeightManager.h1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
