import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/features/pages/auth/screens/otp.dart';
import 'package:wasity/features/pages/auth/widgets/intro.dart';
import 'package:wasity/core/widget/form_field/app_form_field.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/button/app_button.dart';

class Phone extends StatefulWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;

  const Phone({super.key, this.themeNotifier});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController userTypeController = TextEditingController();
  String otpCode = '';

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
        // Handle empty phone number case
      } else if (value.length != 10) {
        // Handle phone number length not equal to 10
      } else if (!value.startsWith('09')) {
        // Handle phone number not starting with '09'
      } else {
        // Valid phone number case
      }
    });
  }

  void generateOTP() async {
    String url = "http://127.0.0.1:8000/api/generateOTP";

    // JSON data to send in POST request
    Map<String, dynamic> data = {
      "number": numberController.text,
      "type": 0,
    };

    // Request headers
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "user-type": userTypeController.text, // Add user type to headers
    };

    try {
      // Send POST request
      var response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(data));

      // Check if request was successful (status code 200 means success)
      if (response.statusCode == 200) {
        // Extract JSON data from response
        Map<String, dynamic> responseData = jsonDecode(response.body);
        if (kDebugMode) {
          print(response.body);
        }
        setState(() {
          otpCode = responseData["otp_code"].toString();
        });

        // Navigate to OTP screen and pass otpCode as argument
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => Otp(
              otpCode: otpCode,
              themeNotifier: widget.themeNotifier,
            ),
          ),
        );
      } else {
        // If there was an error in the request, you can insert an error message here
        _showErrorDialog(
            "Failed to generate OTP", "Status code: ${response.statusCode}");
      }
    } catch (error) {
      _showErrorDialog("Error", error.toString());
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (ctx) => SizedBox(
        height: AppHeightManager.h3,
        child: AlertDialog(
          backgroundColor: AppColorManager.white,
          title: Text(title),
          content: AppTextWidget(
            text: 'Check your internet connection.',
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  generateOTP();
                                }
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

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
