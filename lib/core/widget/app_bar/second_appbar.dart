import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class SecondAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  SecondAppbar({
    required this.titleText,
    Key? key,
    required Null Function() onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: FontSizeManager.fs24,
          color: AppColorManager.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: AppTextWidget(
        text: titleText,
        fontSize: FontSizeManager.fs19,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
      backgroundColor: AppColorManager.navyBlue,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
