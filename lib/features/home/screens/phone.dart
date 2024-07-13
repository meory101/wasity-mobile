import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/features/home/screens/otp.dart';
import 'package:wasity/features/home/widgets/auth/container/intro.dart';
import 'package:wasity/core/widget/button/app_button.dart';
import 'package:wasity/core/widget/form_field/app_form_field.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      _validatePhoneNumber(_phoneController.text);
    });
  }

  void _validatePhoneNumber(String value) {
    setState(() {
      if (value.isEmpty) {
        _errorText = 'Please enter your phone number';
      } else if (value.length != 10) {
        _errorText = 'Phone number must be 10 digits';
      } else if (!value.startsWith('09')) {
        _errorText = 'Phone number must start with 09';
      } else {
        _errorText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.navyBlue,
      body: Column(
        children: [
          const Intro(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w6),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      AppTextWidget(
                        text: "Phone number",
                        fontSize: FontSizeManager.fs20,
                        color: AppColorManager.white,
                        height: AppHeightManager.h03,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      AppTextFormField(
                        controller: _phoneController,
                        prefixIcon: Icon(
                          Icons.phone,
                          color: AppColorManager.white,
                          size: AppRadiusManager.r20,
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (value.length != 10) {
                            return 'Phone number must be 10 digits';
                          } else if (!value.startsWith('09')) {
                            return 'Phone number must start with 09';
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          errorText: _errorText,
                          errorStyle: TextStyle(
                            color: AppColorManager.white,
                            fontSize: FontSizeManager.fs16,
                          ),
                        ),
                      ),
                      SizedBox(height: AppHeightManager.h15),
                      AppElevatedButton(
                        text: "Next",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Otp()),
                            );
                          }
                        }, color: AppColorManager.yellow,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
