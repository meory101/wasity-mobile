import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/helper/language_helper.dart';
import '../../../../core/resource/color_manager.dart';
import '../../../../core/resource/font_manager.dart';
import '../../../../core/widget/button/main_app_button.dart';
import '../../../../core/widget/text/app_text_widget.dart';
import 'package:intl_phone_field/countries.dart';
import 'dart:ui' as ui;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../../core/resource/icon_manager.dart';
import '../../../core/resource/size_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  int maxLength = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.navyBlue,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w4),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppHeightManager.h22,
                ),

                SizedBox(
                  height: AppHeightManager.h20,
                ),
                Align(
                  alignment: LanguageHelper.checkIfLTR(context: context)
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: AppTextWidget(
                    color: AppColorManager.white,
                    padding: const EdgeInsets.only(bottom: 5),
                    text: "phoneNumber".tr(),
                    fontSize: FontSizeManager.fs16,
                  ),
                ),
                SizedBox(
                  height: AppHeightManager.h05,
                ),
                Directionality(
                  textDirection: ui.TextDirection.ltr,
                  child: InternationalPhoneNumberInput(

                    onInputChanged: (PhoneNumber value) {
                      maxLength = countries
                              .firstWhere(
                                  (element) => element.code == value.isoCode)
                              .maxLength -
                          1;

                      maxLength += value.dialCode?.length ?? 0;
                    },
                    inputBorder: InputBorder.none,
                    hintText: '',
                    validator: (value) {
                      if ((value ?? "").isEmpty) {
                        return "emptyFiled".tr();
                      }
                      // if (sendCodeRequest.mobileNumber.length != maxLength) {
                      //   return "invalidNumber".tr();
                      // }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    countrySelectorScrollControlled: true,
                    textStyle: TextStyle(
                        height: 2.2,
                        fontFamily: FontFamilyManager.cairo,
                        color: AppColorManager.textAppColor,
                        fontSize: FontSizeManager.fs17),
                    textAlign: TextAlign.left,
                    initialValue: PhoneNumber(),
                    keyboardAction: TextInputAction.done,
                    cursorColor: AppColorManager.navyBlue,
                    maxLength: 15,
                    selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        leadingPadding: AppWidthManager.w5,
                        trailingSpace: false,
                        showFlags: true,
                        useBottomSheetSafeArea: true,
                        setSelectorButtonAsPrefixIcon: true),
                  ),
                ),
                SizedBox(
                  height: AppHeightManager.h4,
                ),
                Column(
                  children: [
                    MainAppButton(
                      onTap: () {
                        if (formKey.currentState?.validate() == true) {}
                      },
                      borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                      height: AppHeightManager.h6,
                      alignment: Alignment.center,
                      color: AppColorManager.yellow,
                      child: AppTextWidget(
                          text: "logIn".tr(),
                          color: AppColorManager.navyBlue,
                          fontWeight: FontWeight.w400,
                          fontSize: FontSizeManager.fs16),
                    ),
                    SizedBox(
                      height: AppHeightManager.h2,
                    ),
                    AppTextWidget(
                      onTap: () {},
                      text: "continueAsGuest".tr(),
                      fontSize: FontSizeManager.fs16,
                      textDecoration: TextDecoration.underline,
                      decorationColor: AppColorManager.navyBlue,
                      color: AppColorManager.navyBlue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
