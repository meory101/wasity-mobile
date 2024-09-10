import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class AppElevatedButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final VoidCallback onPressed;

  const AppElevatedButton({
    required this.text,
    required this.color,
    required this.onPressed,
    this.textColor,
    this.fontSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(color),
        minimumSize: WidgetStateProperty.all(
          Size(double.infinity, AppHeightManager.h9),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadiusManager.r10),
          ),
        ),
      ),
      onPressed: onPressed,
      child: AppTextWidget(
        text: text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: textColor ?? AppColorManager.navyLightBlue,
              fontSize: fontSize,
            ),
      ),
    );
  }
}
