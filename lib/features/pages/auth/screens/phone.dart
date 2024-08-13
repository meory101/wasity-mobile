import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/pages/auth/screens/otp.dart';
import 'package:wasity/core/widget/form_field/app_form_field.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/button/app_button.dart';
import 'package:wasity/features/pages/auth/widgets/intro.dart';

class Phone extends StatefulWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;

  const Phone({super.key, this.themeNotifier});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController userTypeController = TextEditingController();
  late OTPService otpService;

  @override
  void initState() {
    super.initState();
    otpService = OTPService();
  }

  void _generateOTPAndNavigate() async {
    if (_formKey.currentState!.validate()) {
      try {
        String? otpCode = await otpService.generateOTP(
          numberController.text,
          userTypeController.text,
        );
        if (otpCode != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Otp(
                otpCode: otpCode,
                themeNotifier: widget.themeNotifier,
              ),
            ),
          );
        } else {
          _showErrorDialog("Failed to generate OTP", "Please try again.");
        }
      } catch (error) {
        _showErrorDialog("Error", error.toString());
      }
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColorManager.white,
        title: Text(title),
        content: AppTextWidget(
          text: message,
          fontSize: FontSizeManager.fs16,
          color: AppColorManager.navyBlue,
        ),
        actions: <Widget>[
          TextButton(
            child: const AppTextWidget(
              text: 'OK',
              fontSize: 18,
              color: AppColorManager.navyBlue,
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
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
                              text: "Phone number",
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
                              controller: numberController,
                              fillColor: theme.inputDecorationTheme.fillColor,
                              borderRadius: AppRadiusManager.r6,
                              hintText: '09 - - - - - - - -',
                              prefixIcon: Icon(Icons.phone,
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
                              textInputType: TextInputType.phone,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                } else if (value.length != 10) {
                                  return 'Phone number must be 10 digits';
                                } else if (!value.startsWith('09')) {
                                  return 'Phone number must start with 09';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                            SizedBox(height: AppHeightManager.h12),
                            AppElevatedButton(
                              text: "Next",
                              onPressed: _generateOTPAndNavigate,
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
