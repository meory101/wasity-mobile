import 'package:flutter/material.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/form_field/app_form_field.dart';
import 'package:wasity/features/pages/home/button/filter.dart';

class SearchFormField extends StatelessWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;

  const SearchFormField({super.key, this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
          top: AppHeightManager.h1point2, bottom: AppHeightManager.h1point5),
      child: Row(
        children: [
          Expanded(
            flex: 85,
            child: AppTextFormField(
              fillColor: theme.inputDecorationTheme.fillColor,
              borderRadius: AppRadiusManager.r6,
              hintText: 'search here ...',
              prefixIcon: Icon(Icons.search,
                  color: theme.inputDecorationTheme.hintStyle?.color),
              hintStyle: theme.inputDecorationTheme.hintStyle,
              controller: TextEditingController(),
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.search,
              keyboardType: TextInputType.name, decoration: const InputDecoration(border: InputBorder.none),
         
            ),
          ),
          const Expanded(
            flex: 15,
            child: FilterButton(),
          ),
        ],
      ),
    );
  }
}


  // Color _getSearchFieldFillColor(BuildContext context) {
  //   if (themeNotifier?.value == ThemeMode.dark) {
  //     return AppColorManager.navyLightBlue; 
  //   } else {
  //     return AppColorManager.white; 
  //   }
  // }

  // Color _getSearchFieldHintColor(BuildContext context) {
  //   if (themeNotifier?.value == ThemeMode.dark) {
  //     return AppColorManager.grey; // Dark theme color
  //   } else {
  //     return Theme.of(context).textTheme.headlineSmall?.color ?? Colors.black; // Light theme color
  //   }
  // }

  // TextStyle? _getSearchFieldHintStyle(BuildContext context) {
  //   if (themeNotifier?.value == ThemeMode.dark) {
  //     return Theme.of(context).textTheme.headlineSmall?.copyWith(
  //       color: AppColorManager.grey, // Dark theme color
  //     );
  //   } else {
  //     return Theme.of(context).textTheme.headlineSmall; // Light theme style
  //   }
  // }

