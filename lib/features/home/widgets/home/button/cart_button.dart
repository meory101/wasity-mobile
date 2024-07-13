import 'package:flutter/cupertino.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      borderRadius: BorderRadius.circular(AppRadiusManager.r4),
      shape: BoxShape.circle,
      width: AppWidthManager.w8point5,
      height: AppHeightManager.h8,
      color: AppColorManager.white,
      child: SvgPicture.asset(
        AppIconManager.cart,
        colorFilter: const ColorFilter.mode(
          AppColorManager.grayLightBlue,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
