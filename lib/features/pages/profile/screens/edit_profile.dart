import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/storage/shared/shared_pref.dart';
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
  DateTime? selectedDate;

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final TextEditingController ncontroller = TextEditingController();
  final TextEditingController gcontroller = TextEditingController();
  final TextEditingController econtroller = TextEditingController();

  int _value = 1;
  String name = '';
  String email = '';
  String birthDate = '';
  String gender = '2';
  bool isLoading = true;
  bool _isSaving = false;
  String profileImage = '';
  File? _imageFile;

  final ClientProfileService _clientProfileService = ClientProfileService();
  final ClientProfileServices _clientProfileServices = ClientProfileServices();

  @override
  void initState() {
    super.initState();
    fetchClientProfile();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  Future<void> fetchClientProfile() async {
    try {
      final profile = await _clientProfileService.fetchClientProfile();
      if (profile != null) {
        print(profile.points);
        print("++++++++++++++++++profile.points");
        setState(() {
          name = profile.name;
          email = profile.email;
          birthDate = profile.birthDate;
          gender = profile.gender;
          profileImage = profile.profileImage;
          _value = int.parse(gender);
          isLoading = false;
          AppSharedPreferences.cachePoints(profile.points);
        });
      }
    } catch (e) {
      if (kDebugMode) print('Error fetching profile: $e');
      setState(() => isLoading = false);
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      barrierColor: AppColorManager.shadow2,
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthDate = "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    setState(() => _isSaving = true);

    final response = await _clientProfileServices.updateClientProfile(
      name: name,
      email: email,
      birthDate: birthDate,
      gender: gender,
      imageFile: _imageFile,
    );

    setState(() => _isSaving = false);

    if (response != null && response.statusCode == 200) {
      if (kDebugMode) print('Profile updated successfully');

      if (_imageFile != null) {
        AppSharedPreferences.cacheProfileImage(_imageFile!.path);
      }
      AppSharedPreferences.cacheFullName(name);

      showSuccessDialog();
      await fetchClientProfile();
    } else {
      if (kDebugMode) print('Failed to update profile');
    }
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Profile Updated'),
        content: const Text('Your profile has been updated successfully!'),
        actions: <Widget>[
          TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/ProfileInfo');
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = widget.themeNotifier?.value == ThemeMode.dark;

    if (isLoading) {
      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: SecondAppbar(
        titleText: "Profile",
        onBack: () => Navigator.pushNamed(context, '/ProfileInfo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w6),
          child: Column(
            children: [
              buildProfileImageSection(),
              buildTextField(
                  label: "Name",
                  hintText: "Enter Your Name",
                  value: name,
                  prefixIcon: Icons.person_outline,
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                  isDarkMode: isDarkMode,
                  focusNode: nameFocusNode,
                  controller: ncontroller),
              buildTextField(
                label: "Email",
                hintText: "Enter Your Email",
                value: email,
                prefixIcon: Icons.email_outlined,
                onChanged: (val) => setState(() => email = val),
                isDarkMode: isDarkMode,
                controller: econtroller,
                focusNode: emailFocusNode,
              ),
              buildGenderAndBirthdate(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigation(),
    );
  }

  Widget buildProfileImageSection() {
    return Padding(
      padding: EdgeInsets.only(top: AppHeightManager.h3),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadiusManager.r15),
                child: _imageFile != null
                    ? Image.file(
                        _imageFile!,
                        height: AppHeightManager.h13,
                        width: AppWidthManager.w26,
                        fit: BoxFit.cover,
                      )
                    : profileImage.isNotEmpty
                        ? Image.network(
                            profileImage,
                            height: AppHeightManager.h13,
                            width: AppWidthManager.w26,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            AppImageManager.personalImage,
                            height: AppHeightManager.h13,
                            width: AppWidthManager.w26,
                            fit: BoxFit.cover,
                          ),
              ),
            ],
          ),
          GestureDetector(
            onTap: _pickImage,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadiusManager.r13),
              child: Padding(
                padding: EdgeInsets.only(
                    left: AppWidthManager.w50, top: AppHeightManager.h10),
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

  Widget buildTextField({
    required String label,
    required String hintText,
    required String value,
    required IconData prefixIcon,
    required ValueChanged<String> onChanged,
    required bool isDarkMode,
    required TextEditingController controller,
    required FocusNode focusNode,
  }) {
    final theme = Theme.of(context);

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
          focusNode: focusNode,
          prefixIcon: Icon(prefixIcon, color: theme.iconTheme.color),
          fillColor: theme.inputDecorationTheme.fillColor,
          borderRadius: AppRadiusManager.r6,
          hintText: hintText,
          hintStyle: theme.inputDecorationTheme.hintStyle?.copyWith(
            color: isDarkMode
                ? AppColorManager.grey
                : AppColorManager.navyLightBlue,
          ),
          textColor:
              isDarkMode ? AppColorManager.white : AppColorManager.navyBlue,
          initialValue: value,
          onChanged: onChanged,
        ),
        SizedBox(height: AppHeightManager.h4),
      ],
    );
  }

  Widget buildGenderAndBirthdate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget(
          text: "Birthdate",
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: AppColorManager.white),
        ),
        SizedBox(height: AppHeightManager.h2),
        DecoratedContainer(
          border: Border.all(color: AppColorManager.lightGrey),
          height: AppHeightManager.h5point8,
          width: AppWidthManager.w60,
          borderRadius: BorderRadius.circular(AppRadiusManager.r6),
          color: AppColorManager.navyLightBlue,
          child: GestureDetector(
            onTap: () => _selectDate(context),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: AppWidthManager.w2point5),
                  child: Icon(Icons.date_range_outlined,
                      size: 30, color: Theme.of(context).iconTheme.color),
                ),
                SizedBox(width: AppWidthManager.w4),
                Text(
                  birthDate.isNotEmpty ? birthDate : "Select Birth Date",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: AppHeightManager.h4),
        AppTextWidget(
          text: "Gender",
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: AppColorManager.white),
        ),
        SizedBox(height: AppHeightManager.h1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: RadioListTile<int>(
                title: const Text("Male"),
                value: 1,
                groupValue: _value,
                onChanged: (val) => setState(() {
                  _value = val!;
                  gender = '$_value';
                }),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            Expanded(
              child: RadioListTile<int>(
                title: const Text("Female"),
                value: 2,
                groupValue: _value,
                onChanged: (val) => setState(() {
                  _value = val!;
                  gender = '$_value';
                }),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildBottomNavigation() {
    return DecoratedContainer(
      color: AppColorManager.grey,
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
                  onPressed: () => Navigator.pushNamed(context, '/ProfileInfo'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: _isSaving
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: AppWidthManager.w55,
                      height: AppHeightManager.h6,
                      child: AppElevatedButton(
                        text: 'Save',
                        textColor: AppColorManager.navyLightBlue,
                        fontSize: FontSizeManager.fs18,
                        color: AppColorManager.white,
                        onPressed: _saveProfile,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
