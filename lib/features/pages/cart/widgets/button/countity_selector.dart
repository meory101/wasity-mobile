import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class CountitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CountitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      color: AppColorManager.navyBlue,
      width: AppWidthManager.w26,
      height: AppHeightManager.h4point4,
      child: Row(
        children: [
          SizedBox(width: AppWidthManager.w1),
          GestureDetector(
            onTap: onDecrement,
            child: DecoratedContainer(
              color: AppColorManager.whiteBlue,
              height: AppHeightManager.h3point3,
              width: AppWidthManager.w7,
              child: Center(
                child: SvgPicture.asset(
                  width: AppWidthManager.w4,
                  AppIconManager.minimize,
                  // ignore: deprecated_member_use
                  color: AppColorManager.black,
                ),
              ),
            ),
          ),
          SizedBox(
            width: AppWidthManager.w10,
            child: Center(
              child: AppTextWidget(
                text: '$quantity',
                fontSize: FontSizeManager.fs17,
              ),
            ),
          ),
          GestureDetector(
            onTap: onIncrement,
            child: DecoratedContainer(
              color: AppColorManager.navyLightBlue,
              height: AppHeightManager.h3point3,
              width: AppWidthManager.w7,
              child: Center(
                child: SvgPicture.asset(
                  width: AppWidthManager.w4,
                  AppIconManager.add,
                ),
              ),
            ),
          ),
          SizedBox(width: AppWidthManager.w1),
        ],
      ),
    );
  }
}
