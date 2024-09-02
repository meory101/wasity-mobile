import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/button/app_button.dart';
import 'package:wasity/core/widget/form_field/app_form_field.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/models/appModels.dart';

class SavedAddresses extends StatefulWidget {
  const SavedAddresses({super.key, required this.themeNotifier});

  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  _SavedAddressesState createState() => _SavedAddressesState();
}

class _SavedAddressesState extends State<SavedAddresses> {
  final AddressService _addressService = AddressService();
  final List<Address> _addresses = [];

  @override
  void initState() {
    super.initState();
    _fetchAddresses();
  }

  Future<void> _fetchAddresses() async {
    try {
      final addresses = await _addressService.fetchAddresses(1);
      setState(() {
        _addresses.clear();
        _addresses.addAll(addresses);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = widget.themeNotifier.value == ThemeMode.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: SecondAppbar(
        onBack: () => Navigator.pushNamed(context, '/ProfileInfo'),
        titleText: "Saved Addresses",
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppWidthManager.w3,
            top: AppHeightManager.h6,
            right: AppWidthManager.w3,
          ),
          child: ListView(
            children: _addresses.map((address) {
              return Padding(
                padding: EdgeInsets.only(bottom: AppHeightManager.h5),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? AppColorManager.navyBlue
                        : AppColorManager.shadow,
                    border: Border.all(
                        color: AppColorManager.grayLightBlue,
                        width: AppHeightManager.h02),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _buildAddressTile(
                    address: address,
                    themeNotifier: widget.themeNotifier,
                  ),
                ),
              );
            }).toList(),
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
        Positioned(
          bottom: AppHeightManager.h19,
          right: AppWidthManager.w20,
          left: AppWidthManager.w20,
          child: SizedBox(
            height: AppHeightManager.h7,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(const Color(0xFF818174)),
              ),
              onPressed: _showAddAddressDialog,
              child: AppTextWidget(
                text: "+ Add Address",
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: isDarkMode
                      ? AppColorManager.white
                      : AppColorManager.navyLightBlue,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void _showAddAddressDialog() {
    _showEditDialog(context, null);
  }

  Widget _buildAddressTile({
    required Address address,
    required ValueNotifier<ThemeMode> themeNotifier,
  }) {
    return ListTile(
      title: Text(
        address.name,
        style: TextStyle(
          fontSize: FontSizeManager.fs17,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Row(
        children: [
          Text('Lat: ${address.lat}, Long: ${address.long}'),
        ],
      ),
      leading: Radio(
        value: address.name,
        groupValue: 'address',
        onChanged: (value) {},
      ),
      trailing: IconButton(
        icon: const Icon(Icons.edit_square, color: Colors.yellow),
        onPressed: () {
          _showEditDialog(context, address);
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, Address? currentAddress) {
    final bool isNewAddress = currentAddress == null;
    final TextEditingController controller =
        TextEditingController(text: currentAddress?.name ?? '');
    double lat = currentAddress?.lat ?? 22.0;
    double long = currentAddress?.long ?? 33.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColorManager.navyBlue,
          title: AppTextWidget(
            text: isNewAddress ? 'Add New Address' : 'Edit Address Name',
            fontSize: FontSizeManager.fs18,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextFormField(
                controller: controller,
              ),
              SizedBox(height: AppHeightManager.h2),
              ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(AppColorManager.yellow),
                ),
                onPressed: () {
                     Navigator.pushNamed(context, "/GMap");
                },
                icon: const Icon(
                  Icons.edit_location_alt_outlined,
                  color: AppColorManager.white,
                ),
                label: const AppTextWidget(text: 'Pick Location'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: AppTextWidget(
                text: 'Cancel',
                fontSize: FontSizeManager.fs16,
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(AppColorManager.navyLightBlue),
              ),
              onPressed: () async {
                final name = controller.text;
                final address = Address(
                  id: currentAddress?.id ?? 0,
                  name: name,
                  lat: lat,
                  long: long,
                  clientId: 1,
                );
                try {
                  if (isNewAddress) {
                    await _addressService.addAddress(address);
                  } else {
                    await _addressService.updateAddress(address);
                  }
                  _fetchAddresses();
                } catch (e) {
                  // Handle error
                  print(e);
                }
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              child: AppTextWidget(
                text: 'Save',
                fontSize: FontSizeManager.fs16,
              ),
            ),
          ],
        );
      },
    );
  }
}
