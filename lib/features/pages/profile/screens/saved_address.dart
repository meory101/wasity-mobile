import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/storage/shared/shared_pref.dart';
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
  // ignore: library_private_types_in_public_api
  _SavedAddressesState createState() => _SavedAddressesState();
}

class _SavedAddressesState extends State<SavedAddresses> {
  final AddressService _addressService = AddressService();
  final List<Address> _addresses = [];
  Address? _selectedAddress;

  @override
  void initState() {
    super.initState();
    _fetchAddresses().then((_) {
      _loadSelectedAddress();
    });
  }

  void _loadSelectedAddress() {
    final cachedId = AppSharedPreferences.getSelectedAddressId();
    if (cachedId != null) {
      try {
        final address = _addresses.firstWhere(
          (address) => address.id?.toString() == cachedId,
        );
        setState(() {
          _selectedAddress = address;
        });
      } catch (e) {
        setState(() {
          _selectedAddress = null;
        });
      }
    }
  }

  Future<void> _fetchAddresses() async {
    try {
      final clientIdString = AppSharedPreferences.getClientId();
      final clientId = int.tryParse(clientIdString) ?? 0;

      final addresses = await _addressService.fetchAddresses(clientId);
      setState(() {
        _addresses.clear();
        _addresses.addAll(addresses);
      });

      if (kDebugMode) {
        print('Fetched addresses for clientId $clientId: ${_addresses.length}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching addresses: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = widget.themeNotifier.value == ThemeMode.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: SecondAppbar(
        onBack: () => Navigator.pop(context),
        titleText: "Saved Addresses",
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: AppWidthManager.w3,
              top: AppHeightManager.h6,
              right: AppWidthManager.w3,
            ),
            child: _addresses.isEmpty
                ? Center(
                    child: AppTextWidget(
                      text: 'No addresses found.',
                      fontSize: FontSizeManager.fs16,
                      color: AppColorManager.grayLightBlue,
                    ),
                  )
                : ListView.builder(
                    itemCount: _addresses.length,
                    itemBuilder: (context, index) {
                      final address = _addresses[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: AppHeightManager.h3),
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
                    },
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
                    onPressed: _saveSelectedAddressId,
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
              child: AppElevatedButton(
                onPressed: _showAddAddressDialog,
                color: AppColorManager.shadow2,
                textColor: AppColorManager.grayLightBlue,
                text: "+ Add Address",
              ),
            ),
          ),
        ],
      ),
    );
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
      leading: Radio<Address>(
        activeColor: AppColorManager.yellow,
        value: address,
        groupValue: _selectedAddress,
        onChanged: (Address? value) {
          setState(() {
            _selectedAddress = value;
          });
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.edit_square, color: Colors.yellow),
        onPressed: () {
          _showEditDialog(context, address);
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, Address address) {
    final TextEditingController controller =
        TextEditingController(text: address.name);
    double lat = address.lat;
    double long = address.long;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColorManager.navyBlue,
          title: AppTextWidget(
            text: 'Edit Address',
            fontSize: FontSizeManager.fs18,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextFormField(
                  controller: controller,
                ),
                SizedBox(height: AppHeightManager.h2),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColorManager.yellow,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/MapScreen",
                        arguments: {'lat': lat, 'long': long}).then((result) {
                      if (result != null && result is Map) {
                        setState(() {
                          lat = result['lat'];
                          long = result['long'];
                        });
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.edit_location_alt_outlined,
                    color: AppColorManager.white,
                  ),
                  label: const AppTextWidget(text: 'Pick Location'),
                ),
              ],
            ),
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
              onPressed: () async {
                final name = controller.text.trim();
                if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid name')),
                  );
                  return;
                }

                final updatedAddress = UpdateAddress(
                  id: address.id ?? 0,
                  name: name,
                  lat: lat,
                  long: long,
                );

                try {
                  await _addressService.updateAddress(updatedAddress);

                  if (mounted) {
                    await _fetchAddresses();
                  }
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                } catch (e) {
                  if (kDebugMode) {
                    print(
                        'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff$updatedAddress');
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                    print('Error updating address: $e');
                  }
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to update address')),
                  );
                }
              },
              child: AppTextWidget(
                text: 'Update',
                fontSize: FontSizeManager.fs16,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddAddressDialog() {
    final TextEditingController nameController = TextEditingController();
    double lat = 22.0;
    double long = 33.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColorManager.navyBlue,
          title: AppTextWidget(
            text: 'Add New Address',
            fontSize: FontSizeManager.fs18,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextFormField(
                  controller: nameController,
                ),
                SizedBox(height: AppHeightManager.h2),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColorManager.yellow,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/MapScreen").then((result) {
                      if (result != null && result is Map) {
                        setState(() {
                          lat = result['lat'];
                          long = result['long'];
                        });
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.edit_location_alt_outlined,
                    color: AppColorManager.white,
                  ),
                  label: const AppTextWidget(text: 'Pick Location'),
                ),
              ],
            ),
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
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid name')),
                  );
                  return;
                }

                final clientIdString = AppSharedPreferences.getClientId();
                final clientId = int.tryParse(clientIdString) ?? 0;

                final newAddress = Address(
                  id: null,
                  name: name,
                  lat: lat,
                  long: long,
                  clientId: clientId,
                );

                try {
                  await _addressService.addAddress(newAddress);
                  if (mounted) {
                    await _fetchAddresses();
                  }
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Address added successfully')),
                  );
                } catch (e) {
                  if (kDebugMode) {
                    print('Error adding address: $e');
                  }
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to add address')),
                  );
                }
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

  void _saveSelectedAddressId() async {
    if (_selectedAddress != null) {
      if (kDebugMode) {
        print('Selected Address: ${_selectedAddress!.toJson()}');
      }

      AppSharedPreferences.cacheSelectedAddressId(
        id: _selectedAddress!.id.toString(),
        location: _selectedAddress!.name,
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColorManager.lightGray,
            title: AppTextWidget(
              text: 'تم إضافة العنوان بنجاح',
              fontSize: FontSizeManager.fs18,
              color: AppColorManager.white,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: AppTextWidget(
                  text: 'OK',
                  fontSize: FontSizeManager.fs16,
                  color: AppColorManager.white,
                ),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an address to apply')),
      );
    }
  }
}
