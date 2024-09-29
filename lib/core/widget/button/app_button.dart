import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadiusManager.r6),
      child: Container(
        width: double.infinity,
        child: GestureDetector(
          onTap: onPressed,
          child: DecoratedContainer(
            height: AppHeightManager.h6point2,
            color: color ?? AppColorManager.yellow,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              AppTextWidget(
                text: text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: textColor ?? AppColorManager.navyLightBlue,
                      fontSize: fontSize,
                    ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
