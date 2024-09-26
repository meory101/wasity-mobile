import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class DeliveryTypeSlider extends StatelessWidget {
  final int? currentValue;
  final ValueChanged<int?> onValueChanged;
  final double iconSize;
  final double textSize;

  const DeliveryTypeSlider({
    super.key,
    required this.currentValue,
    required this.onValueChanged,
    this.iconSize = 25.0,
    this.textSize = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor =
        isDarkMode ? AppColorManager.white : AppColorManager.navyLightBlue;
    final textColor =
        isDarkMode ? Colors.white : AppColorManager.navyLightBlue;

    return SizedBox(
      height: 60,
      width: 130,
      child: CupertinoSlidingSegmentedControl<int>(
        thumbColor: AppColorManager.yellow,
        groupValue: currentValue,
        children: {
          0: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppIconManager.time,
                // ignore: deprecated_member_use
                color: iconColor,
                height: iconSize,
                fit: BoxFit.scaleDown,
              ),
              AppTextWidget(
                text: "Economic",
                color: textColor,
                fontSize: textSize,
              ),
            ],
          ),
          1: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppIconManager.speed,
                // ignore: deprecated_member_use
                color: iconColor,
                height: iconSize,
                fit: BoxFit.scaleDown,
              ),
              AppTextWidget(
                text: "Direct",
                color: textColor,
                fontSize: textSize,
              ),
            ],
          ),
        },
        onValueChanged: onValueChanged,
      ),
    );
  }
}
