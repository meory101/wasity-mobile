import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/key_manger.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/features/home/widgets/auth/button/app_button.dart';
import 'package:wasity/core/widget/form_field/app_form_field.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/features/home/widgets/auth/container/intro.dart';

class Otp extends StatefulWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;

  const Otp({super.key, this.themeNotifier});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final _formKey = GlobalKey<FormState>();

  String? _validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the OTP code';
    } else if (value.length != 6) {
      return 'OTP code must be 4 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'OTP code must contain only numbers';
    }
    return null;
  }

  TextEditingController userTypeController = TextEditingController();
  TextEditingController numberController = TextEditingController();

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
      jsonDecode(response.body);
      if (kDebugMode) {
        print(response.body);
      }
      setState(() {
      });

      // التوجيه إلى صفحة عرض OTP مع تمرير الرمز
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
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
                            text: "verification code",
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
                            fillColor: theme.inputDecorationTheme.fillColor,
                            hintText: AppKeyManager.code,
                            prefixIcon: Icon(Icons.mail_lock_outlined,
                                color: theme
                                    .inputDecorationTheme.hintStyle?.color),
                            hintStyle:
                                theme.inputDecorationTheme.hintStyle?.copyWith(
                              color: isDarkMode
                                  ? AppColorManager.navyLightBlue
                                  : AppColorManager.grey,
                            ),
                            textColor: isDarkMode
                                ? AppColorManager.navyBlue
                                : AppColorManager.white,
                            keyboardType: TextInputType.number,
                            validator: _validateOtp,
                            onChanged: (value) {
                              return null;
                            
                            },
                            decoration:
                                const InputDecoration(border: InputBorder.none),
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
                                color: AppColorManager.grey),
                          ),
                          SizedBox(
                            width: AppWidthManager.w5,
                          ),
                          Expanded(
                            flex: 3,
                            child: AppElevatedButton(
                              text: "Verify",
                              onPressed: () {
                                generateOTP();
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
        ],
      ),
    );
  }
}
