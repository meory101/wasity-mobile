import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/features/home/widgets/home/button/circular_icon_button.dart';

class MainAppBar extends StatelessWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;

  const MainAppBar({super.key, this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor =
        isDarkMode ? AppColorManager.white : AppColorManager.navyBlue;

    return SizedBox(
      height: AppHeightManager.h12,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: AppWidthManager.w3Point8),
            child: Builder(
              builder: (context) {
                return CircularIconButton(
                  buttonIcon: SvgPicture.asset(
                    AppIconManager.list,
                    // ignore: deprecated_member_use
                    color: iconColor,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: AppWidthManager.w3),
            child: CircularIconButton(
              buttonIcon: Image.asset(AppImageManager.personalImage),
              onPressed: () {},
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextWidget(
                text: "Hello",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
              ),
              SizedBox(height: AppHeightManager.h02),
              AppTextWidget(
                text: "Ahmad!",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: iconColor),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: AppWidthManager.w26),
            child: CircularIconButton(
              buttonIcon: SvgPicture.asset(
                AppIconManager.notification,
                // ignore: deprecated_member_use
                color: iconColor,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
