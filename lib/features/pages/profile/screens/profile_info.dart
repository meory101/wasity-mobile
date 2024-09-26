import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/storage/shared/shared_pref.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
// import 'package:wasity/features/pages/auth/screens/finger_print.dart';

class ProfileInfo extends StatefulWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;

  const ProfileInfo({super.key, this.themeNotifier});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  String? _profileImage;
  String _fullName = "User name";

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final profileImage = AppSharedPreferences.getProfileImage();
    final fullName = AppSharedPreferences.getFullName();

    setState(() {
      _profileImage = profileImage.isNotEmpty ? profileImage : null;
      _fullName = fullName.isNotEmpty ? fullName : "User name";
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = widget.themeNotifier?.value == ThemeMode.dark;

    Color getTextColor() =>
        isDarkMode ? AppColorManager.white : AppColorManager.navyLightBlue;
    Color getDividerColor() =>
        isDarkMode ? AppColorManager.navyLightBlue : AppColorManager.grey;

    Widget profileHeader() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: AppHeightManager.h5),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadiusManager.r15),
              child: DecoratedContainer(
                height: AppHeightManager.h8,
                width: AppWidthManager.w16,
                child: _profileImage != null
                    ? Image.file(
                        File(_profileImage!),
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        AppImageManager.productImage,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SizedBox(width: AppWidthManager.w5),
            Expanded(
              child: AppTextWidget(
                text: _fullName,
                style: theme.textTheme.headlineMedium
                    ?.copyWith(color: getTextColor()),
              ),
            ),
            //!!FingerprintAuthPageFingerprintAuthPageFingerprintAuthPage

            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/EditProfile'),
             
              icon: const Icon(Icons.edit_square,
                  color: AppColorManager.lightGrey),
            ),
          ],
        ),
      );
    }

    Widget profileItem(
        IconData? icon, String title, String subtitle, String route) {
      return Column(
        children: [
          ListTile(
            leading: Icon(icon, color: AppColorManager.yellow),
            title: AppTextWidget(
              text: title,
              style:
                  theme.textTheme.displayLarge?.copyWith(color: getTextColor()),
            ),
            subtitle: AppTextWidget(
              text: subtitle,
              style: theme.textTheme.headlineSmall
                  ?.copyWith(color: getTextColor()),
            ),
            onTap: () => Navigator.pushNamed(context, route),
          ),
          Divider(
            height: AppHeightManager.h1,
            color: getDividerColor(),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: SecondAppbar(
        titleText: "Profile",
        onBack: () => Navigator.pushNamed(context, '/ButtonNavbar'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w6),
        child: Column(
          children: [
            profileHeader(),
            Expanded(
              child: ListView(
                children: [
                  profileItem(Icons.category_outlined, "Orders",
                      "Ongoing orders, Recent orders..", '/OrderHistory'),
                  profileItem(Icons.payment_rounded, "Payment",
                      "Saved card, Wallets", '/Wallet'),
                  profileItem(Icons.location_on_outlined, "Saved Address",
                      "Home, Office", '/SavedAddresses'),
                  profileItem(Icons.settings, "Settings",
                      "app settings, Dark mode", '/SettingsPage'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
