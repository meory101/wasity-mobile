import 'package:flutter/cupertino.dart';
import 'package:wasity/core/resource/color_manager.dart';

class CircularIconButton extends StatelessWidget {
  final Color? buttonColor;
  final Widget buttonIcon;
  CircularIconButton({ this.buttonColor,required this.buttonIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration:  BoxDecoration(
        color: buttonColor?? AppColorManager.white,
        shape: BoxShape.circle
      ),
      child: buttonIcon,
    );
  }
}
