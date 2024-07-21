import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/features/auth/screens/generate_otp_screen.dart';
import 'package:wasity/core/widget/form_field/app_form_field.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/features/auth/widgets/button/app_button.dart';
import 'package:wasity/features/auth/widgets/container/intro.dart';

class Phone extends StatefulWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;

  const Phone({super.key, this.themeNotifier});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

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
      } else if (value.length != 10) {
      } else if (!value.startsWith('09')) {
      } else {
      }
    });
  }

  TextEditingController numberController = TextEditingController();
  TextEditingController userTypeController = TextEditingController();
  int otpCode = 0;
  void generateOTP() async {
    String url = "http://127.0.0.1:8000/api/generateOTP";

    // بيانات الـ JSON التي ترسلها في الطلب POST
    Map<String, dynamic> data = {
      "number": numberController.text,
      "type": 0,
    };

    // ترويسة الطلب
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "user-type": userTypeController.text, // إضافة نوع المستخدم إلى الترويسة
    };

    // إرسال الطلب POST
    var response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(data));

    // تحقق من نجاح الطلب (status code 200 يعني نجاح)
    if (response.statusCode == 200) {
      // استخراج بيانات الـ JSON من الرد
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (kDebugMode) {
        print(response.body);
      }
      setState(() {
        otpCode = responseData["otp_code"];
      });

      // يمكنك تنفيذ أي عمليات إضافية هنا بعد استلام الـ OTP
    } else {
      // إذا كان هناك خطأ في الطلب، يمكنك إدراج رسالة خطأ هنا
      if (kDebugMode) {
        print("Failed to generate OTP. Status code: ${response.statusCode}");
      }
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
                              decoration:
                                  const InputDecoration(border: InputBorder.none),
                            ),
                            SizedBox(height: AppHeightManager.h12),
                            AppElevatedButton(
                              text: "Next",
                              onPressed: () {
                                generateOTP();
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Otp()),
                                  );
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
