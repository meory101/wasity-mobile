import 'package:flutter/material.dart';
import '../../resource/color_manager.dart';
import '../../resource/size_manager.dart';

class DecoratedContainer extends StatelessWidget {
  const DecoratedContainer({
    super.key,
    this.color,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.child,
    this.border,
    this.alignment,
    this.shape,
    this.boxShadow,
    this.image,
    this.borderRadius,
    this.isGradient,
    this.isDarkMode,  // Add this parameter
  });

  final Color? color;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Widget? child;
  final BoxBorder? border;
  final AlignmentGeometry? alignment;
  final BoxShape? shape;
  final List<BoxShadow>? boxShadow;
  final DecorationImage? image;
  final BorderRadiusGeometry? borderRadius;
  final bool? isGradient;
  final bool? isDarkMode;  // Add this parameter

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      alignment: alignment,
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        gradient: isGradient != null && isGradient!
            ? isDarkMode != null && isDarkMode!
                ? const LinearGradient(
                    colors: [
                      AppColorManager.navyBlue,
                      AppColorManager.navyBlue,
                      AppColorManager.grayLightBlue,
                      AppColorManager.grayLightBlue,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 0.25, 0.75, 0.03],
                  )
                : const LinearGradient(
                    colors: [
                      AppColorManager.grayLightBlue,
                      AppColorManager.grayLightBlue,
                      AppColorManager.navyBlue,
                      AppColorManager.navyBlue,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 0.25, 0.75, 0.03],
                  )
            : null,
        border: border,
        image: image,
        borderRadius: shape == BoxShape.circle
            ? null
            : borderRadius ?? BorderRadius.circular(AppRadiusManager.r3),
        boxShadow: boxShadow ??
            [
              const BoxShadow(
                color: AppColorManager.navyBlue,
                blurRadius: 0,
                spreadRadius: 0,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
        shape: shape ?? BoxShape.rectangle,
        color: color ?? AppColorManager.white,
      ),
      child: child,
    );
  }
}
