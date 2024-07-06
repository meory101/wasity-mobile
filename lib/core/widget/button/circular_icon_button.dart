import 'package:flutter/cupertino.dart';
<<<<<<< HEAD
import 'package:flutter/rendering.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wasity/core/resource/size_manager.dart';
=======
import 'package:wasity/core/resource/color_manager.dart';
>>>>>>> origin/ahmad

class CircularIconButton extends StatelessWidget {
  final Color? buttonColor;
  final Widget buttonIcon;
<<<<<<< HEAD
  CircularIconButton({this.buttonColor, required this.buttonIcon});
=======
  CircularIconButton({ this.buttonColor,required this.buttonIcon});
>>>>>>> origin/ahmad

  @override
  Widget build(BuildContext context) {
    return Container(
<<<<<<< HEAD
      width: 12.w,
      height: 18.h,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: buttonColor ?? AppColorManager.white,
        border: Border.all(
          width: AppRadiusManager.r1,
          color: AppColorManager.shadow,
        ),
        shape: BoxShape.circle,
=======
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration:  BoxDecoration(
        color: buttonColor?? AppColorManager.white,
        shape: BoxShape.circle
>>>>>>> origin/ahmad
      ),
      child: buttonIcon,
    );
  }
}
