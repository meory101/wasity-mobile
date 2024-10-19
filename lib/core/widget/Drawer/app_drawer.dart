import 'dart:io'; // لاستعمال File لعرض الصور من التخزين
import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/storage/shared/shared_pref.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/button/circular_icon_button.dart';

class AppDrawer extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const AppDrawer({super.key, required this.themeNotifier});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isSwitched = true;
  String? _profileImage;
  String _fullName = "User name";

  @override
  void initState() {
    super.initState();
    isSwitched = widget.themeNotifier.value == ThemeMode.dark;
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final profileImage = AppSharedPreferences.getProfileImage();
    final fullName = AppSharedPreferences.getFullName();

    setState(() {
      _profileImage = profileImage.isNotEmpty
          ? profileImage
          : AppImageManager.personalImage;
      _fullName = fullName.isNotEmpty ? fullName : "User name";
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;
    final Color textColor =
        isDarkMode ? Colors.white : AppColorManager.navyLightBlue;

    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.only(top: AppHeightManager.h3Point5),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: AppHeightManager.h5,
                width: AppWidthManager.w25,
                child: Image.asset(
                  AppImageManager.logo,
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppHeightManager.h16,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColorManager.lightGrey,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: AppWidthManager.w3),
                    child: CircularIconButton(
                      buttonIcon: _profileImage != null
                          ? Image.file(
                              File(_profileImage!),
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  AppImageManager
                                      .personalImage,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : Image.asset(
                              AppImageManager.personalImage,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  AppTextWidget(
                    text: _fullName,
                    fontSize: FontSizeManager.fs20,
                    fontWeight: FontWeight.w800,
                    color: AppColorManager.navyBlue,
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.dark_mode,
              color: AppColorManager.yellow,
            ),
            title: Row(
              children: [
                AppTextWidget(
                  text: 'Dark Mode',
                  style:
                      theme.textTheme.displayMedium?.copyWith(color: textColor),
                ),
                SizedBox(
                  width: AppWidthManager.w15,
                ),
                Transform.scale(
                  scale: AppRadiusManager.r0Point5,
                  child: Switch(
                    activeColor: AppColorManager.white,
                    activeTrackColor: AppColorManager.grey,
                    inactiveThumbColor: AppColorManager.white,
                    inactiveTrackColor: Colors.yellow,
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                        widget.themeNotifier.value =
                            isSwitched ? ThemeMode.dark : ThemeMode.light;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: AppColorManager.yellow,
            ),
            title: AppTextWidget(
              text: 'Settings',
              style: theme.textTheme.displayMedium?.copyWith(color: textColor),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: AppColorManager.yellow,
            ),
            title: AppTextWidget(
              text: 'About us',
              style: theme.textTheme.displayMedium?.copyWith(color: textColor),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              color: AppColorManager.yellow,
            ),
            title: AppTextWidget(
              text: 'Logout',
              style: theme.textTheme.displayMedium?.copyWith(color: textColor),
            ),
            onTap: () {
              _logout(context);
            },
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/Phone');
  }
}
