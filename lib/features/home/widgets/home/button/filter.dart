import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppHeightManager.h1point5),
      child: Container(
        width: AppWidthManager.w12,
        height: AppHeightManager.h8,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: AppColorManager.navyLightBlue,
          borderRadius: BorderRadius.circular(AppRadiusManager.r6),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppWidthManager.w2),
          child: SvgPicture.asset(
            AppIconManager.verticalSliders,
            colorFilter: const ColorFilter.mode(
              AppColorManager.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
