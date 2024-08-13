import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/button/app_button.dart';

class SavedAddresses extends StatelessWidget {
  const SavedAddresses({super.key, required this.themeNotifier});

  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SecondAppbar(
        onBack: () => Navigator.pop(context),
        titleText: "Saved Addresses",
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppWidthManager.w5,
            top: AppHeightManager.h6,
          ),
          child: ListView(
            children: [
              _buildAddressTile(
                title: 'Home',
                address: ' الدحاديل مفرق كازيةالبهلول ',
                phone: '3234932',
                themeNotifier: themeNotifier,
              ),
              SizedBox(
                height: AppHeightManager.h5,
              ),
              _buildAddressTile(
                title: 'Office',
                address: 'الله يرزقني بمكتب',
                phone: '0994191372',
                themeNotifier: themeNotifier,
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DecoratedContainer(
              height: AppHeightManager.h12,
              color: AppColorManager.navyLightBlue,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppHeightManager.h2point5,
                  horizontal: AppWidthManager.w6,
                ),
                child: AppElevatedButton(
                  text: "Apply",
                  color: AppColorManager.white,
                  onPressed: () {},
                  textColor: AppColorManager.navyBlue,
                  fontSize: FontSizeManager.fs17,
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget _buildAddressTile({
    required String title,
    required String address,
    required String phone,
    required ValueNotifier<ThemeMode> themeNotifier,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: FontSizeManager.fs17,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(address),
          Text('Phone:  $phone'),
        ],
      ),
      trailing: Radio(
        value: title,
        groupValue: 'address',
        onChanged: (value) {},
      ),
    );
  }
}
