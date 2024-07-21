import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class Offer extends StatelessWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;

  const Offer({super.key, this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = themeNotifier?.value == ThemeMode.dark;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: AppHeightManager.h3Point5,
            top: AppHeightManager.h1point5,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadiusManager.r5),
            child: SizedBox(
              height: AppHeightManager.h18,
              width: AppWidthManager.w110,
              child: Image.asset(
                AppImageManager.offerImage,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          top: AppHeightManager.h9,
          left: AppWidthManager.w6,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/offer');
                },
                child: AppTextWidget(
                  text: 'View More',
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: isDarkMode
                        ? AppColorManager.white
                        : AppColorManager.navyBlue,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_sharp,
                  color: isDarkMode
                      ? AppColorManager.white
                      : AppColorManager.navyBlue,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/offer');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
