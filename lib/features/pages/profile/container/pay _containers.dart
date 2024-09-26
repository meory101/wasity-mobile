import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/features/api/api_link.dart';
import 'wallet_card.dart';

class SelectableContainers extends StatefulWidget {
    final Function(int) onPaymentMethodSelected;
  const SelectableContainers({super.key, required this.onPaymentMethodSelected});

  @override
  _SelectableContainersState createState() => _SelectableContainersState();
}

class _SelectableContainersState extends State<SelectableContainers> {
  
  int _selectedValue = 0;
  double? balance;
  int? points;

  @override
  void initState() {
    super.initState();
    _loadSelectedValue();
  }

  Future<void> _loadSelectedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedValue = prefs.getInt('selected_payment') ?? 0;
    });
  }

  Future<void> _fetchWalletData() async {
    double? fetchedBalance = await WalletService.fetchAccountData(0);
    int? fetchedPoints = await WalletService.fetchPoints();

    setState(() {
      balance = fetchedBalance;
      points = fetchedPoints;
    });
  }
 void _saveSelectedValue(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selected_payment', value);
    widget.onPaymentMethodSelected(value); 
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSelectableContainer(0, AppImageManager.cash, "cash"),
        _buildSelectableContainer(1, AppImageManager.card, "epay"),
      ],
    );
  }

  Widget _buildSelectableContainer(int value, String imagePath, String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedValue = value;
        });
         _saveSelectedValue(value); 
      },
      onLongPress: () async {
        if (value == 1) {
          await _fetchWalletData();
          showModalBottomSheet(
            backgroundColor: AppColorManager.grayLightBlue,
            barrierColor: AppColorManager.shadow2,
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: AppHeightManager.h5),
                    child: AppTextWidget(
                      text: "Your Card",
                      color: AppColorManager.white,
                      fontSize: FontSizeManager.fs20,
                    ),
                  ),
                  WalletCard(
                    balance: balance,
                    points: points,
                  ),
                ],
              );
            },
          );
        }
      },
      child: Container(
        width: 140,
        height: 100,
        decoration: BoxDecoration(
          color: AppColorManager.navyBlue,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _selectedValue == value
                ? AppColorManager.navyBlue
                : AppColorManager.shadow,
            width: 3,
          ),
          boxShadow: _selectedValue == value
              ? [
                  BoxShadow(
                    spreadRadius: AppRadiusManager.r3,
                    blurRadius: AppRadiusManager.r6,
                    color: AppColorManager.grey,
                  )
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: AppHeightManager.h5,
              width: AppWidthManager.w16,
              child: Image.asset(imagePath),
            ),
            const SizedBox(height: 10),
            Text(text,
                style: const TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
