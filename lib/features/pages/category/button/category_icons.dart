import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';

import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class Categorys extends StatelessWidget {
  final List<String> categories = [
    "category1",
    "category2",
    "category3",
    "category4",
    "category5",
    "category6",
    "category7",
    "category8",
    "category9",
  ];

  final ValueNotifier<ThemeMode>? themeNotifier;
  Categorys({super.key, this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;
    final Color textColor =
        isDarkMode ? AppColorManager.white : AppColorManager.navyBlue;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories
            .map(
              (category) => Padding(
                padding: EdgeInsets.only(right: AppWidthManager.w2),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/SubcategoryPage',
                          arguments: category,
                        );
                      },
                      child: DecoratedContainer(
                        width: AppWidthManager.w13point5,
                        height: AppHeightManager.h6point2,
                        borderRadius:
                            BorderRadius.circular(AppRadiusManager.r6),
                        image: DecorationImage(
                          image: AssetImage(AppImageManager.categoryImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: AppHeightManager.h03),
                    AppTextWidget(
                      text: category,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: textColor,
                          ),
                    ),
                    SizedBox(height: AppHeightManager.h5),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
