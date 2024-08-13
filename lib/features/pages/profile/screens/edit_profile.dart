import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/button/app_button.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/form_field/app_form_field.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class EditProfile extends StatefulWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;

  const EditProfile({super.key, this.themeNotifier});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String birthdate = '';
  int gender = 1;

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  Future<void> _getProfile() async {
    const url = 'http://127.0.0.1:8000/api/getClientProfile/1';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (!mounted) return;
      setState(() {
        name = data['name'] ?? '';
        email = data['email'] ?? '';
        birthdate = data['birthdate'] ?? '';
        gender = data['gender'] == 'Female' ? 1 : 2;
      });
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      const url = 'http://127.0.0.1:8000/api/updateClientProfile';
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': '1',
          'name': name,
          'email': email,
          'birthdate': birthdate,
          'gender': gender.toString(),
        }),
      );

      if (response.statusCode == 200) {
        _showSuccessDialog();
      } else {
        throw Exception('Failed to update profile');
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: AppTextWidget(
            text: 'Success',
            fontSize: FontSizeManager.fs16,
            color: AppColorManager.navyBlue,
          ),
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: AppColorManager.green),
              SizedBox(width: AppWidthManager.w5),
              AppTextWidget(
                text: "Profile updated successfully!",
                fontSize: FontSizeManager.fs16,
                color: AppColorManager.navyBlue,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/ProfileInfo');
              },
              child: const AppTextWidget(
                text: "OK",
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: SecondAppbar(
        titleText: "Profile",
        onBack: () {
          Navigator.pushNamed(context, '/ButtonNavbar');
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppWidthManager.w6,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildProfileImage(),
                SizedBox(height: AppHeightManager.h5),
                _buildTextField(
                  label: "Name",
                  hintText: "Enter Your Name",
                  prefixIcon: Icons.person_3_outlined,
                  initialValue: name,
                  onChanged: (value) => setState(() => name = value!),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter your name';
                    if (RegExp(r'[0-9]').hasMatch(value)) return 'Name cannot contain numbers';
                    return null;
                  },
                ),
                SizedBox(height: AppHeightManager.h4),
                _buildTextField(
                  label: "Email",
                  hintText: "Example@gmail.com",
                  prefixIcon: Icons.email_outlined,
                  initialValue: email,
                  onChanged: (value) => setState(() => email = value!),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter your email';
                    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value)) return 'Please enter a valid email address';
                    return null;
                  },
                ),
                SizedBox(height: AppHeightManager.h8),
                _buildBirthdateAndGenderFields(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildProfileImage() {
    return Padding(
      padding: EdgeInsets.only(top: AppHeightManager.h3),
      child: Stack(
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadiusManager.r15),
              child: DecoratedContainer(
                height: AppHeightManager.h13,
                width: AppWidthManager.w26,
                child: Image.asset(
                  AppImageManager.productImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            right: AppWidthManager.w50,
            top: AppHeightManager.h10,
            child: GestureDetector(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadiusManager.r13),
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
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required IconData prefixIcon,
    required String initialValue,
    required void Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    final theme = Theme.of(context);
    final isDarkMode = widget.themeNotifier?.value == ThemeMode.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget(
          text: label,
          style: theme.textTheme.headlineLarge?.copyWith(
            color: isDarkMode ? AppColorManager.white : AppColorManager.grey,
          ),
        ),
        SizedBox(height: AppHeightManager.h1point2),
        AppTextFormField(
          initialValue: initialValue,
          fillColor: theme.inputDecorationTheme.fillColor,
          borderRadius: AppRadiusManager.r6,
          hintText: hintText,
          prefixIcon: Icon(prefixIcon, color: theme.inputDecorationTheme.hintStyle?.color),
          hintStyle: theme.inputDecorationTheme.hintStyle?.copyWith(
            color: isDarkMode ? AppColorManager.grey : AppColorManager.navyLightBlue,
          ),
          textColor: isDarkMode ? AppColorManager.white : AppColorManager.navyBlue,
          // onChanged: onChanged,
          validator: validator,
          decoration: const InputDecoration(border: InputBorder.none), keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildBirthdateAndGenderFields() {
    Theme.of(context);
    
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            label: "Birthdate",
            hintText: "Enter Your Birthdate",
            prefixIcon: Icons.date_range_outlined,
            initialValue: birthdate,
            onChanged: (value) => setState(() => birthdate = value!),
            validator: (value) => value == null || value.isEmpty ? 'Please enter your birthdate' : null,
          ),
        ),
        SizedBox(width: AppWidthManager.w9),
        _buildGenderRadioButtons(),
      ],
    );
  }

  Widget _buildGenderRadioButtons() {
    final isDarkMode = widget.themeNotifier?.value == ThemeMode.dark;
    
    return Row(
      children: [
        _buildGenderRadioButton(label: "Female", value: 1),
        SizedBox(width: AppWidthManager.w6),
        _buildGenderRadioButton(label: "Male", value: 2),
      ],
    );
  }

  Widget _buildGenderRadioButton({required String label, required int value}) {
    final isDarkMode = widget.themeNotifier?.value == ThemeMode.dark;

    return Column(
      children: [
        SizedBox(
          height: AppHeightManager.h3,
          width: AppWidthManager.w16,
          child: Radio<int>(
            activeColor: AppColorManager.yellow,
            onChanged: (newValue) => setState(() => gender = newValue!),
            value: value,
            groupValue: gender,
          ),
        ),
        AppTextWidget(
          text: label,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: isDarkMode ? AppColorManager.white : AppColorManager.navyLightBlue,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return DecoratedContainer(
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
                    Navigator.pushNamed(context, '/ButtonNavbar');
                  },
                ),
              ),
            ),
            SizedBox(width: 15),
            SizedBox(
              width: AppWidthManager.w55,
              height: AppHeightManager.h6,
              child: AppElevatedButton(
                text: 'Save',
                textColor: AppColorManager.navyLightBlue,
                fontSize: FontSizeManager.fs18,
                color: AppColorManager.white,
                onPressed: _updateProfile,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
