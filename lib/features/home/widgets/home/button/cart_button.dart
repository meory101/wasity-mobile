import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final containerColor =
       AppColorManager.navyBlue;
    final iconColor =
       AppColorManager.navyLightBlue ;

    return DecoratedContainer(
      borderRadius: BorderRadius.circular(AppRadiusManager.r4),
      shape: BoxShape.circle,
      width: AppWidthManager.w8point5,
      height: AppHeightManager.h8,
      color: containerColor,
      child: SvgPicture.asset(
        AppIconManager.cart,
        colorFilter: ColorFilter.mode(
          iconColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
