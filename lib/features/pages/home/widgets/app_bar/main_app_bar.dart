import 'dart:io'; // لاستعمال File لعرض الصور من التخزين
import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/storage/shared/shared_pref.dart';
import 'package:wasity/core/widget/button/circular_icon_button.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/features/pages/home/widgets/button/delivery_type_slidder.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';

class MainAppBar extends StatefulWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;

  const MainAppBar({super.key, this.themeNotifier});

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  int? deliveryType;
  String? _profileImage;
  String _fullName = "Name";

  @override
  void initState() {
    super.initState();
    deliveryType = AppSharedPreferences.getDeliveryType();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final profileImage = AppSharedPreferences.getProfileImage();
    final fullName = AppSharedPreferences.getFullName();

    setState(() {
      _profileImage = profileImage.isNotEmpty
          ? profileImage
          : AppImageManager.personalImage;
      _fullName = fullName.isNotEmpty ? fullName.split(" ")[0] : "Name";
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor =
        isDarkMode ? AppColorManager.white : AppColorManager.navyLightBlue;

    return Padding(
      padding: EdgeInsets.only(top: AppHeightManager.h1point3),
      child: SizedBox(
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
                      fit: BoxFit.none,
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
                buttonIcon: _profileImage != null
                    ? Image.file(
                        File(_profileImage!),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AppImageManager.personalImage, 
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(
                        AppImageManager.personalImage,
                        fit: BoxFit.cover,
                      ),
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
                  text: "$_fullName!",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: iconColor),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: AppWidthManager.w12),
              child: DeliveryTypeSlider(
                currentValue: deliveryType,
                onValueChanged: (value) {
                  setState(() {
                    deliveryType = value;
                    AppSharedPreferences.cacheDeliveryType(value!);
                  });
                },
                iconSize: 25.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
