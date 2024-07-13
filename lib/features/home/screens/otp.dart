import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/key_manger.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/button/app_button.dart';
import 'package:wasity/core/widget/form_field/app_form_field.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/features/home/widgets/auth/container/intro.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final _formKey = GlobalKey<FormState>();
  String? _otpCode;

  String? _validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the OTP code';
    } else if (value.length != 4) {
      return 'OTP code must be 4 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'OTP code must contain only numbers';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.navyBlue,
      body: Column(
        children: [
          Intro(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w5),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      AppTextWidget(
                        text: "",
                        fontSize: FontSizeManager.fs20,
                        color: AppColorManager.white,
                        height: AppHeightManager.h03,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      AppTextFormField(
                        hintText: AppKeyManager.code,
                        hintStyle: TextStyle(color: AppColorManager.grey),
                        prefixIcon: Icon(
                          Icons.vpn_key_rounded,
                          color: AppColorManager.white,
                          size: AppRadiusManager.r20,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        validator: _validateOtp,
                        onChanged: (value) {
                          _otpCode = value;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: AppHeightManager.h15),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: AppElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: "<-",
                          color: AppColorManager.grey,
                        ),
                      ),
                      SizedBox(
                        width: AppWidthManager.w5,
                      ),
                      Expanded(
                        flex: 3,
                        child: AppElevatedButton(
                          text: "Verify",
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              Navigator.pushNamed(context, '/HomeScreen');
                            }
                          },
                          color: AppColorManager.yellow,
                        ),
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
}
