import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/text/price_text_widget.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:wasity/features/pages/cart/widgets/button/cart_button.dart';

class NewArrivaisContainer extends StatelessWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;
  final NewItem newItem;

  const NewArrivaisContainer({
    super.key,
    this.themeNotifier,
    required this.newItem,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = themeNotifier?.value == ThemeMode.dark;

    return Padding(
      padding: EdgeInsets.only(bottom: AppHeightManager.h5),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadiusManager.r5),
                child: Container(
                  width: AppWidthManager.w42,
                  height: AppHeightManager.h36,
                  color: isDarkMode
                      ? AppColorManager.navyLightBlue
                      : AppColorManager.whiteBlue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: AppHeightManager.h2,
                          bottom: AppHeightManager.h02,
                          left: AppWidthManager.w3Point5,
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppRadiusManager.r5),
                          child: SizedBox(
                            height: AppHeightManager.h19,
                            width: AppWidthManager.w35,
                            child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "/ProductInfo",
                                      arguments: newItem.id);
                                },
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'http://127.0.0.1:8000/storage/${newItem.image}',
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.warning_rounded,
                                    size: AppRadiusManager.r30,
                                  ),
                                  fit: BoxFit.fill,
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: AppHeightManager.h1,
                          left: AppWidthManager.w3,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: newItem.name,
                              style: theme.textTheme.displayMedium?.copyWith(
                                color: isDarkMode
                                    ? AppColorManager.white
                                    : AppColorManager.navyBlue,
                              ),
                            ),
                            PriceText(
                              price: newItem.price,
                              style: theme.textTheme.displayMedium?.copyWith(
                                color: isDarkMode
                                    ? AppColorManager.white
                                    : AppColorManager.navyBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: AppWidthManager.w29,
                top: AppHeightManager.h17,
                child: const CartButton(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}