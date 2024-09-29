import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/key_manger.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/storage/shared/shared_pref.dart';
import 'package:wasity/core/widget/form_field/app_form_field.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/button/app_button.dart';
import 'package:wasity/features/pages/auth/widgets/intro.dart';

class Otp extends StatefulWidget {
  final String otpCode;
  final ValueNotifier<ThemeMode>? themeNotifier;
  final String clientId; // Add clientId parameter

  const Otp({super.key, required this.otpCode, this.themeNotifier, required this.clientId});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _showOtpNotification(widget.otpCode);
  }

  void _showOtpNotification(String otpCode) {
    Fluttertoast.showToast(
      msg: "Your OTP code is: $otpCode\nTap to copy",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 8,
      backgroundColor: AppColorManager.navyLightBlue,
      textColor: Colors.white,
      fontSize: 16.0,
    ).then((_) {
      Clipboard.setData(ClipboardData(text: otpCode));
      Fluttertoast.showToast(
        msg: "OTP copied to clipboard",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    });
  }

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

  void _saveClientIdAndNavigate() async {
    // Store the clientId passed from the previous screen
    AppSharedPreferences.cacheClientId(widget.clientId);

    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/ButtonNavbar');
    }
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
                    padding: EdgeInsets.symmetric(
                      vertical: AppHeightManager.h40,
                      horizontal: AppWidthManager.w6,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        SizedBox(height: AppHeightManager.h15),
                        AppTextFormField(
                          controller: otpController,
                          fillColor: theme.inputDecorationTheme.fillColor,
                          borderRadius: AppRadiusManager.r6,
                          hintText: AppKeyManager.code,
                          prefixIcon: Icon(Icons.lock,
                              color: theme.inputDecorationTheme.hintStyle?.color),
                          hintStyle: theme.inputDecorationTheme.hintStyle?.copyWith(
                            color: isDarkMode
                                ? AppColorManager.grey
                                : AppColorManager.navyLightBlue,
                          ),
                          textColor: isDarkMode
                              ? AppColorManager.white
                              : AppColorManager.navyBlue,
                          textInputType: TextInputType.number,
                          validator: _validateOtp,
                        ),
                        SizedBox(height: AppHeightManager.h15),
                        AppElevatedButton(
                          text: "Verify",
                          onPressed: _saveClientIdAndNavigate,
                          color: AppColorManager.yellow,
                        ),
                        SizedBox(height: AppHeightManager.h5),
                        AppElevatedButton(
                          text: "Cancel",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: AppColorManager.yellow,
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
