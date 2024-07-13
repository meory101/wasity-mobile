import 'package:flutter/widgets.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          DecoratedContainer(
            height: AppHeightManager.h40,
            isGradient: true,
            child: Stack(
              children: [
                Image.asset(
                  AppImageManager.logo,
                ),
                Positioned(
                  left: AppWidthManager.w22,
                  top: AppHeightManager.h17,
                  child: Row(
                    children: [
                      AppTextWidget(
                        text: " Everything in one place !",
                        fontSize: FontSizeManager.fs22,
                        color: AppColorManager.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),],);
  }
}