import 'package:flutter/material.dart';
import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/size_manager.dart';

class AppTextFormField extends StatelessWidget {
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? enabled;
  final String? Function(String?)? validator;
  final String? Function(String?)? onFieldSubmitted;
  final Function()? editingComplete;
  final void Function(String)? onChanged; 
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final FocusNode? focusNode;
  final String? labelText;
  final String? initialValue;
  final TextAlignVertical? textAlignVertical;
  final Color? textColor;
  final Color? labelColor;
  final int? maxLines;
  final int? minLines;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final String? hintText;
  final bool? outlinedBorder;
  final bool? expand;
  final bool? autoFocus;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool? filled;
  final bool? readOnly;

  const AppTextFormField({
    super.key,
    this.borderRadius,
    this.minLines,
    this.filled,
    this.readOnly,
    this.enabled,
    this.suffixIcon,
    this.fillColor,
    this.expand,
    this.contentPadding,
    this.controller,
    this.obscureText,
    this.autoFocus,
    this.validator,
    this.hintStyle,
    this.editingComplete,
    this.onChanged, 
    this.textInputType,
    this.textInputAction,
    this.textAlignVertical,
    this.focusNode,
    this.labelText,
    this.textColor = AppColorManager.white,
    this.labelColor,
    this.onFieldSubmitted,
    this.initialValue,
    this.maxLines,
    this.prefixIcon,
    this.hintText,
    this.outlinedBorder,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key(initialValue ?? ""),
      readOnly: readOnly ?? false,
      textAlignVertical: textAlignVertical,
      onFieldSubmitted: onFieldSubmitted,
      cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
      validator: validator,
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      autofocus: autoFocus ?? false,
      onEditingComplete: editingComplete,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      minLines: minLines,
      maxLines: maxLines,
      initialValue: initialValue,
      enabled: enabled,
      expands: expand ?? false,
      decoration: InputDecoration(
        filled: filled ?? true,
        fillColor: fillColor ?? AppColorManager.navyLightBlue,
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintStyle: hintStyle ?? _defaultHintStyle(context),
        prefixIconColor: Colors.grey,
        suffixIconColor: Colors.grey,
        contentPadding: contentPadding ?? _defaultContentPadding(),
        labelText: labelText,
        labelStyle: TextStyle(
          color: labelColor,
          fontSize: FontSizeManager.fs16,
          fontWeight: FontWeight.bold,
          fontFamily: FontFamilyManager.cairo,
        ),
        errorStyle: TextStyle(
          fontSize: FontSizeManager.fs14,
          fontFamily: FontFamilyManager.cairo,
        ),
        enabledBorder: _buildOutlineInputBorder(AppColorManager.lightGreyOpacity6),
        disabledBorder: _buildOutlineInputBorder(Colors.transparent),
        focusedBorder: _buildOutlineInputBorder(AppColorManager.lightGreyOpacity6),
        border: _buildOutlineInputBorder(Theme.of(context).primaryColor),
      ),
      style: TextStyle(
        color: textColor,
        fontSize: FontSizeManager.fs16,
        fontFamily: FontFamilyManager.cairo,
      ),
    );
  }

  // Helper methods to simplify repetitive code
  TextStyle _defaultHintStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).inputDecorationTheme.hintStyle?.color,
      fontSize: FontSizeManager.fs16,
      fontWeight: FontWeight.normal,
    );
  }

  EdgeInsetsGeometry _defaultContentPadding() {
    return EdgeInsets.symmetric(
      horizontal: AppWidthManager.w3,
      vertical: AppHeightManager.h1,
    );
  }

  OutlineInputBorder _buildOutlineInputBorder(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius ?? AppRadiusManager.r10),
      ),
      borderSide: BorderSide(color: borderColor),
    );
  }
}
