// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';

import '../../resource/size_manager.dart';


class MainAppButton extends StatelessWidget {
  const MainAppButton({
    Key? key,
    this.width,
    this.height,
    this.color,
    this.borderColor,
    this.haveShadow,
    this.outLinedBorde,
    this.child,
    this.padding,
    this.margin,
    this.alignment,
    this.onTap,
    this.borderRadius,
  }) : super(key: key);
  final double? width;
  final double? height;
  final Color? color;
  final Color? borderColor;
  final bool? haveShadow;
  final bool? outLinedBorde;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final void Function()? onTap;
  final BorderRadiusGeometry? borderRadius;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding,
        alignment: alignment,
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: outLinedBorde == true
              ? Border.all(
                  color: borderColor ?? AppColorManager.yellow,
                )
              : null,
          boxShadow: haveShadow == true
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.45),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset:
                        // changes position of shadow
                        const Offset(0, 0),
                  ),
                ]
              : null,
          color: outLinedBorde == true ? AppColorManager.white : color,
          borderRadius:
              borderRadius ?? BorderRadius.circular(AppRadiusManager.r3),
        ),
        child: child,
      ),
    );
  }
}
