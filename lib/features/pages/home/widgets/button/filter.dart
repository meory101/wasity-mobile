import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(left: AppWidthManager.w2),
      child: Container(
        width: AppWidthManager.w10,
        height: AppHeightManager.h5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(AppRadiusManager.r6),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppWidthManager.w2),
          child: SvgPicture.asset(AppIconManager.verticalSliders,
              // ignore: deprecated_member_use
              color: theme.inputDecorationTheme.hintStyle?.color),
        ),
      ),
    );
  }
}
