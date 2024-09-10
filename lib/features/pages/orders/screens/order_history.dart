import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/features/pages/home/widgets/form_field/search_form_field.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key, required this.themeNotifier});
  final ValueNotifier<ThemeMode>? themeNotifier;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // ignore: unrelated_type_equality_checks
    final isDarkMode = themeNotifier == ThemeMode.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SecondAppbar(
        titleText: "Save Orders",
        onBack: () => Navigator.pushNamed(context, '/ProfileInfo'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w4),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppWidthManager.w5),
              child: SearchFormField(
                themeNotifier: themeNotifier,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: DecoratedContainer(
                color: themeNotifier!.value == ThemeMode.dark
                    ? AppColorManager.navyLightBlue
                    : AppColorManager.whiteBlue,
                height: AppHeightManager.h20,
                width: AppWidthManager.w87,
                child: Padding(
                  padding: EdgeInsets.all(AppRadiusManager.r10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: DecoratedContainer(
                              color: themeNotifier!.value == ThemeMode.dark
                                  ? AppColorManager.navyLightBlue
                                  : AppColorManager.whiteBlue,
                              height: AppHeightManager.h12,
                              width: AppWidthManager.w25,
                              child: InkWell(
                                  child: Image.asset(
                                    AppImageManager.productImage,
                                    fit: BoxFit.cover,
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      "/ProductInfo",
                                    );
                                  }),
                            ),
                          ),
                          // ?Product name
                          Column(
                            children: [
                              AppTextWidget(
                                text: "Product Name",
                                style: theme.textTheme.displayMedium?.copyWith(
                                  color: themeNotifier!.value == ThemeMode.dark
                                      ? AppColorManager.white
                                      : AppColorManager.navyBlue,
                                ),
                              ),
                              //?View location
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "/GMap");
                                },
                                child: AppTextWidget(
                                  text: "View location",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: AppColorManager.red),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: AppHeightManager.h7),
                            child: DecoratedContainer(
                              height: AppHeightManager.h3Point5,
                              width: AppWidthManager.w20,
                              color: AppColorManager.shadow,
                              child: Center(
                                child: AppTextWidget(
                                  text: "Ongoing",
                                  style: theme.textTheme.displaySmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: isDarkMode
                                          ? AppColorManager.red
                                          : AppColorManager.green),
                                  color: AppColorManager.error,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: AppColorManager.grey,
                      ),
                      Row(
                        children: [
                          AppTextWidget(
                            text: "Date Order :",
                            style: theme.textTheme.displaySmall?.copyWith(
                              color: isDarkMode
                                  ? AppColorManager.navyLightBlue
                                  : AppColorManager.white,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
