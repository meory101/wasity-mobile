import 'package:flutter/material.dart';

import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/form_field/app_form_field.dart';
import 'package:wasity/features/home/widgets/home/button/filter.dart';

class SearchFormField extends StatelessWidget {
  const SearchFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppHeightManager.h1point2),
      child: Row(
        children: [
          Expanded(
            flex: 85,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadiusManager.r5),
              ),
              child: AppTextFormField(
                fillColor: AppColorManager.navyLightBlue,
                borderRadius: AppRadiusManager.r6,
                hintText: 'search here ...',
                prefixIcon:
                    const Icon(Icons.search, color: AppColorManager.grey),
                hintStyle: TextStyle(
                  color: AppColorManager.grey,
                  fontSize: FontSizeManager.fs19,
                ),
                controller: TextEditingController(),
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.search,
                textColor: AppColorManager.white,
              ),
            ),
          ),
          //!filter
          const Expanded(
            flex: 15,
            child: FilterButton(),
          ),
        ],
      ),
    );
  }
}
