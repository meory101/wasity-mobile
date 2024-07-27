import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class SecondAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final VoidCallback onBack;

  const SecondAppbar({
    required this.titleText,
    required this.onBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: FontSizeManager.fs24,
          color: AppColorManager.white,
        ),
        onPressed: onBack,
      ),
      title: AppTextWidget(
        text: titleText,
        style: Theme.of(context).textTheme.headlineMedium!,
      ),
      centerTitle: true,
      backgroundColor: AppColorManager.navyLightBlue,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
