import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
// ignore: depend_on_referenced_packages
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wasity/core/resource/size_manager.dart';

class CircularIconButton extends StatelessWidget {
  final Color? buttonColor;
  final Widget buttonIcon;
  final VoidCallback? onPressed;

  const CircularIconButton(
      {super.key, this.buttonColor, required this.buttonIcon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 12.w,
        height: 18.h,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          border: Border.all(
            width: AppRadiusManager.r1,
            color: AppColorManager.shadow,
          ),
          shape: BoxShape.circle,
        ),
        child: buttonIcon,
      ),
    );
  }
}
