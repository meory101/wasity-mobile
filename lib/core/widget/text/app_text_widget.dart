import 'package:flutter/material.dart';
import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';

class AppTextWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final double? height;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color? color;
  final Color? decorationColor;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextStyle? style;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool? softWrap;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;

  const AppTextWidget({
    Key? key,
    required this.text,
    this.fontSize,
    this.height,
    this.fontWeight,
    this.fontStyle,
    this.color = AppColorManager.white,
    this.decorationColor,
    this.textDecoration,
    this.textAlign,
    this.textDirection,
    this.style,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.padding,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Text(
          text,
          maxLines: maxLines,
          overflow: overflow ?? TextOverflow.ellipsis,
          softWrap: softWrap,
          textAlign: textAlign,
          textDirection: textDirection,
          style: style ??
              TextStyle(
                fontFamily: FontFamilyManager.cairo,
                fontSize: fontSize ?? FontSizeManager.fs14,
                fontWeight: fontWeight,
                color: color,
                decoration: textDecoration,
                decorationColor: decorationColor,
                height: height,
              ),
        ),
      ),
    );
  }
}
