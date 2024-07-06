import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/button/circular_icon_button.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeightManager.h12,
      child: Row(
        children: [
          CircularIconButton(
            buttonColor: AppColorManager.red,
            buttonIcon: SvgPicture.asset(
              colorFilter: const ColorFilter.mode(
                  AppColorManager.white, BlendMode.srcIn),
              AppIconManager.notification,
            ),
          )
        ],
      ),
    );
  }
}
