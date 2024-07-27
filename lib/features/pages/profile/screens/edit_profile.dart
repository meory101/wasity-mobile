import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/button/app_button.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasity/core/widget/form_field/app_form_field.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class EditProfile extends StatefulWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;

  const EditProfile({super.key, this.themeNotifier});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = widget.themeNotifier?.value == ThemeMode.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SecondAppbar(
        titleText: "Profile",
        onBack: () {
          Navigator.pushNamed(context, '/ProfileInfo');
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            right: AppWidthManager.w6,
            left: AppWidthManager.w6,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: AppHeightManager.h3),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppRadiusManager.r15),
                          child: DecoratedContainer(
                            height: AppHeightManager.h13,
                            width: AppWidthManager.w26,
                            child: Image.asset(
                              AppImageManager.productImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppRadiusManager.r13),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: AppWidthManager.w50,
                              top: AppHeightManager.h10),
                          child: DecoratedContainer(
                            color: AppColorManager.yellow,
                            height: AppHeightManager.h3point3,
                            width: AppWidthManager.w7,
                            child: Center(
                              child: SvgPicture.asset(
                                width: AppWidthManager.w4,
                                AppIconManager.add,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppHeightManager.h5,
              ),
              Row(
                children: [
                  AppTextWidget(
                    text: "Name",
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: isDarkMode
                          ? AppColorManager.white
                          : AppColorManager.grey,
                    ),
                    height: AppHeightManager.h02,
                  ),
                ],
              ),
              SizedBox(
                height: AppHeightManager.h1point2,
              ),
              AppTextFormField(
                fillColor: theme.inputDecorationTheme.fillColor,
                borderRadius: AppRadiusManager.r6,
                hintText: "Enter Your Name",
                prefixIcon: Icon(Icons.person_3_outlined,
                    color: theme.inputDecorationTheme.hintStyle?.color),
                hintStyle: theme.inputDecorationTheme.hintStyle?.copyWith(
                  color: isDarkMode
                      ? AppColorManager.grey
                      : AppColorManager.navyLightBlue,
                ),
                textColor: isDarkMode
                    ? AppColorManager.white
                    : AppColorManager.navyBlue,
                textInputType: TextInputType.name,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  setState(() {});
                  return null;
                },
                decoration: const InputDecoration(border: InputBorder.none),
              ),

              //?email
              SizedBox(
                height: AppHeightManager.h4,
              ),
              Row(
                children: [
                  AppTextWidget(
                    text: "Email",
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: isDarkMode
                          ? AppColorManager.white
                          : AppColorManager.grey,
                    ),
                    height: AppHeightManager.h02,
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(top: AppHeightManager.h1point2),
                child: AppTextFormField(
                  fillColor: theme.inputDecorationTheme.fillColor,
                  borderRadius: AppRadiusManager.r6,
                  hintText: "Example@gmail.com",
                  prefixIcon: Icon(Icons.email_outlined,
                      color: theme.inputDecorationTheme.hintStyle?.color),
                  hintStyle: theme.inputDecorationTheme.hintStyle?.copyWith(
                    color: isDarkMode
                        ? AppColorManager.grey
                        : AppColorManager.navyLightBlue,
                  ),
                  textColor: isDarkMode
                      ? AppColorManager.white
                      : AppColorManager.navyBlue,
                  textInputType: TextInputType.name,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    setState(() {});
                    return null;
                  },
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),

              //?birthdate
              SizedBox(
                height: AppHeightManager.h8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextWidget(
                    text: "Birthdate",
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: isDarkMode
                          ? AppColorManager.white
                          : AppColorManager.grey,
                    ),
                  ),
                  AppTextWidget(
                    text: "Gender",
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: isDarkMode
                          ? AppColorManager.white
                          : AppColorManager.grey,
                    ),
                    height: AppHeightManager.h02,
                  ),
                ],
              ),
              SizedBox(
                height: AppHeightManager.h3,
              ),
              //!سيتم التعديل عليها حسب شكل الداتا
              Row(
                children: [
                  SizedBox(
                    width: AppWidthManager.w40,
                    child: AppTextFormField(
                      fillColor: theme.inputDecorationTheme.fillColor,
                      borderRadius: AppRadiusManager.r6,
                      hintText: "Enter Your Birthdate",
                      prefixIcon: Icon(Icons.date_range_outlined,
                          color: theme.inputDecorationTheme.hintStyle?.color),
                      hintStyle: theme.inputDecorationTheme.hintStyle?.copyWith(
                        color: isDarkMode
                            ? AppColorManager.grey
                            : AppColorManager.navyLightBlue,
                      ),
                      textColor: isDarkMode
                          ? AppColorManager.white
                          : AppColorManager.navyBlue,
                      textInputType: TextInputType.datetime,
                      keyboardType: TextInputType.datetime,
                      onChanged: (value) {
                        setState(() {});
                        return null;
                      },
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: AppWidthManager.w9,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: AppHeightManager.h3,
                            width: AppWidthManager.w16,
                            child: Radio(
                              activeColor: AppColorManager.yellow,
                              onChanged: (value) {
                                setState(() {
                                  _value = value!;
                                });
                              },
                              value: 1,
                              groupValue: _value,
                            ),
                          ),
                          AppTextWidget(
                            text: "Female",
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: isDarkMode
                                  ? AppColorManager.white
                                  : AppColorManager.navyLightBlue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: AppWidthManager.w6,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: AppHeightManager.h3,
                            width: AppWidthManager.w16,
                            child: Radio(
                              activeColor: AppColorManager.yellow,
                              onChanged: (value) {
                                setState(() {
                                  _value = value!;
                                });
                              },
                              value: 2,
                              groupValue: _value,
                            ),
                          ),
                          AppTextWidget(
                            text: "Male",
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: isDarkMode
                                  ? AppColorManager.white
                                  : AppColorManager.navyLightBlue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: DecoratedContainer(
        color: AppColorManager.navyLightBlue,
        height: AppHeightManager.h9,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: AppHeightManager.h6,
                  child: AppElevatedButton(
                    text: 'Cancel',
                    fontSize: FontSizeManager.fs16,
                    color: AppColorManager.navyBlue,
                    textColor: Colors.grey,
                    onPressed: () {
                      Navigator.pushNamed(context, '/ProfileInfo');
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SizedBox(
                  width: AppWidthManager.w55,
                  height: AppHeightManager.h6,
                  child: AppElevatedButton(
                    text: 'Save',
                    textColor: AppColorManager.navyLightBlue,
                    fontSize: FontSizeManager.fs18,
                    color: AppColorManager.white,
                    onPressed: () {
                      Navigator.pushNamed(context, '/ProfileInfo');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
