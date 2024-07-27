import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';

import 'package:wasity/core/resource/key_manger.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/form_field/app_form_field.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/button/app_button.dart';
import 'package:wasity/features/pages/auth/widgets/intro.dart';

class Otp extends StatefulWidget {
  final String otpCode;
  final ValueNotifier<ThemeMode>? themeNotifier;

  const Otp({super.key, required this.otpCode, this.themeNotifier});

  @override
  // ignore: library_private_types_in_public_api
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();

  String? _validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the OTP code';
    } else if (value.length != 6) {
      return 'OTP code must be 6 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'OTP code must contain only numbers';
    } else if (value != widget.otpCode) {
      return 'Entered OTP does not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = widget.themeNotifier?.value == ThemeMode.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                const Intro(),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: AppHeightManager.h40,
                      right: AppWidthManager.w6,
                      left: AppWidthManager.w6,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            AppTextWidget(
                              text: "Verification Code",
                              style: theme.textTheme.headlineLarge?.copyWith(
                                color: isDarkMode
                                    ? AppColorManager.grey
                                    : AppColorManager.grey,
                              ),
                              height: AppHeightManager.h03,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            AppTextFormField(
                              controller: otpController,
                              fillColor: theme.inputDecorationTheme.fillColor,
                              borderRadius: AppRadiusManager.r6,
                              hintText: AppKeyManager.code,
                              prefixIcon: Icon(Icons.lock,
                                  color: theme
                                      .inputDecorationTheme.hintStyle?.color),
                              hintStyle: theme.inputDecorationTheme.hintStyle
                                  ?.copyWith(
                                color: isDarkMode
                                    ? AppColorManager.grey
                                    : AppColorManager.navyLightBlue,
                              ),
                              textColor: isDarkMode
                                  ? AppColorManager.white
                                  : AppColorManager.navyBlue,
                              textInputType: TextInputType.number,
                              keyboardType: TextInputType.number,
                              validator: _validateOtp,
                              onChanged: (value) {
                                setState(() {});
                                return null;
                              },
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            ),
                            SizedBox(height: AppHeightManager.h12),
                            AppElevatedButton(
                              text: "Verify",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.pushNamed(context, '/HomeScreen');
                                }
                              },
                              color: AppColorManager.yellow,
                            ),
                            SizedBox(height: AppHeightManager.h10),
                            AppElevatedButton(
                              text: "Cancel",
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              color: AppColorManager.yellow,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
