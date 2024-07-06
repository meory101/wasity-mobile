import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../resource/font_manager.dart';
import '../../resource/size_manager.dart';
import '../text/app_text_widget.dart';
import 'app_form_field.dart';

/**
 * Created by Eng.Eyad AlSayed on 4/23/2024.
 */

class TitleAppFormFiled extends StatelessWidget {
  const TitleAppFormFiled(
      {super.key,
      required this.hint,
      required this.title,
      required this.onChanged,
      required this.validator,
      this.initValue,
      this.suffixIcon,
      this.onIconTaped,
      this.readOnly,
      this.multiLines});

  final String title, hint;
  final String? Function(String?) onChanged;
  final String? Function(String?) validator;
  final String? suffixIcon, initValue;
  final bool? readOnly;
  final bool? multiLines;
  final Function()? onIconTaped;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget(
          text: title,
          fontSize: FontSizeManager.fs16,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: AppHeightManager.h1point5,
        ),
        SizedBox(
          child: AppTextFormField(
            readOnly: readOnly,
            suffixIcon: suffixIcon != null && onIconTaped != null
                ? InkWell(
                    onTap: onIconTaped,
                    child: Padding(
                      padding: EdgeInsets.all(AppWidthManager.w2point5),
                      child: SvgPicture.asset(
                        suffixIcon ?? "",
                      ),
                    ),
                  )
                : null,
            initialValue: initValue,
            minLines: multiLines == true ? 5 : 1,
            validator: validator,
            onChanged: onChanged,
            textInputAction: TextInputAction.next,
            hintText: hint,
            textInputType: TextInputType.name,
          ),
        ),
      ],
    );
  }
}
