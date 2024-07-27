import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      children: [
        DecoratedContainer(
          height: AppHeightManager.h100,
          isGradient: true,
          isDarkMode: isDarkMode,  // Pass the isDarkMode flag
          child: Stack(
            children: [
              Image.asset(
                AppImageManager.logo,
              ),
              Positioned(
                left: AppWidthManager.w21,
                top: AppHeightManager.h17,
                child: Row(
                  children: [
                    AppTextWidget(
                      text: " Everything in one place !",
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: isDarkMode
                            ? AppColorManager.white
                            : AppColorManager.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
