import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
// import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/button/app_button.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/form_field/app_form_field.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/features/api/api_link.dart';

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
  String? profileImageUrl;
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  Future<void> _getProfile() async {
    const url = '${Config.baseUrl}/getClientProfile/1';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (!mounted) return;
        setState(() {
          name = data['name'] ?? '';
          email = data['email'] ?? '';
          birthdate = data['birth_date'] ?? '';
          gender = data['gender'] == 'Female' ? 1 : 2;
          profileImageUrl = data['profile_image'] != null
              ? '${Config.imageUrl}/${data['profile_image']}'
              : null;
        });
      } else {
        _showErrorDialog("Failed to load profile data.");
      }
    } catch (e) {
      _showErrorDialog("Failed to load profile data.");
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      const url = '${Config.baseUrl}/updateClientProfile';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['id'] = '1';
      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['birth_date'] = birthdate;
      request.fields['gender'] = gender.toString();

      if (_profileImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'profile_image', _profileImage!.path));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        _showSuccessDialog();
      } else {
        _showErrorDialog("Failed to update profile.");
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

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: AppTextWidget(
            text: 'Error',
            fontSize: FontSizeManager.fs16,
            color: AppColorManager.navyBlue,
          ),
          content: Row(
            children: [
              const Icon(Icons.error, color: AppColorManager.error),
              SizedBox(width: AppWidthManager.w5),
              AppTextWidget(
                text: message,
                fontSize: FontSizeManager.fs16,
                color: AppColorManager.navyBlue,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (RegExp(r'[0-9]').hasMatch(value)) {
                      return 'Name cannot contain numbers';
                    }
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
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
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
              child: _profileImage != null
                  ? Image.file(
                      _profileImage!,
                      fit: BoxFit.cover,
                      height: AppHeightManager.h13,
                      width: AppWidthManager.w26,
                    )
                  : profileImageUrl != null
                      ? Image.network(
                          profileImageUrl!,
                          fit: BoxFit.cover,
                          height: AppHeightManager.h13,
                          width: AppWidthManager.w26,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildDefaultProfileImage();
                          },
                        )
                      : _buildDefaultProfileImage(),
            ),
          ),
          Positioned(
            right: AppWidthManager.w50,
            top: AppHeightManager.h10,
            child: GestureDetector(
              onTap: _pickImage,
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

  Widget _buildDefaultProfileImage() {
    return DecoratedContainer(
      color: AppColorManager.grey.withOpacity(0.3),
      height: AppHeightManager.h13,
      width: AppWidthManager.w26,
      child: Center(
        child: AppTextWidget(
          text: "Add Photo",
          fontSize: FontSizeManager.fs16,
          color: AppColorManager.navyBlue,
        ),
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
          prefixIcon: Icon(prefixIcon,
              color: theme.inputDecorationTheme.hintStyle?.color),
          hintStyle: theme.inputDecorationTheme.hintStyle?.copyWith(
            color: isDarkMode
                ? AppColorManager.grey
                : AppColorManager.navyLightBlue,
          ),
          textColor:
              isDarkMode ? AppColorManager.white : AppColorManager.navyBlue,
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildBirthdateAndGenderFields() {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            label: "Birthdate",
            hintText: "dd/mm/yyyy",
            prefixIcon: Icons.date_range_outlined,
            initialValue: birthdate,
            onChanged: (value) => setState(() => birthdate = value!),
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter your birthdate'
                : null,
          ),
        ),
        SizedBox(width: AppWidthManager.w7),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(
                text: "Gender",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppColorManager.grey,
                    ),
              ),
              SizedBox(height: AppHeightManager.h1point2),
              Container(
                height: AppHeightManager.h7,
                decoration: BoxDecoration(
                  color: AppColorManager.white,
                  borderRadius: BorderRadius.circular(AppRadiusManager.r6),
                ),
                child: DropdownButtonFormField<int>(
                  value: gender,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Female',
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('Male',
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                  ],
                  onChanged: (value) => setState(() => gender = value ?? 1),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppWidthManager.w6, vertical: AppHeightManager.h6),
      child: AppElevatedButton(
        text: "Save",
        onPressed: _updateProfile,
        color: AppColorManager.white,
      ),
    );
  }
}
