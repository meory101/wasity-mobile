import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';

class ButtonNavbar extends StatelessWidget {
  const ButtonNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppRadiusManager.r10),
            topRight: Radius.circular(AppRadiusManager.r10)),
        child: DecoratedContainer(
          child: NavigationBar(
            selectedIndex: 0,
            elevation: 0,
            indicatorColor: AppColorManager.yellow,
            height: AppHeightManager.h9,
            backgroundColor: AppColorManager.navyLightBlue,
            destinations: [
              Padding(
                padding: EdgeInsets.only(top: AppHeightManager.h3),
                child: NavigationDestination(
                  icon: SvgPicture.asset(
                    AppIconManager.homeFill,
                    colorFilter: const ColorFilter.mode(
                      AppColorManager.white,
                      BlendMode.srcIn,
                    ),
                    width: AppWidthManager.w12,
                    height: AppHeightManager.h4,
                  ),
                  label: '',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: AppHeightManager.h3),
                child: NavigationDestination(
                  icon: SvgPicture.asset(
                    AppIconManager.categoryFill,
                    colorFilter: const ColorFilter.mode(
                      AppColorManager.white,
                      BlendMode.srcIn,
                    ),
                    width: AppWidthManager.w12,
                    height: AppHeightManager.h4,
                  ),
                  label: '',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: AppHeightManager.h3),
                child: NavigationDestination(
                  icon: SvgPicture.asset(
                    AppIconManager.cartFill,
                    colorFilter: const ColorFilter.mode(
                      AppColorManager.white,
                      BlendMode.srcIn,
                    ),
                    width: AppWidthManager.w12,
                    height: AppHeightManager.h4,
                  ),
                  label: '',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: AppHeightManager.h3),
                child: NavigationDestination(
                  icon: SvgPicture.asset(
                    AppIconManager.profileFill,
                    colorFilter: const ColorFilter.mode(
                      AppColorManager.white,
                      BlendMode.srcIn,
                    ),
                    width: AppWidthManager.w12,
                    height: AppHeightManager.h4,
                  ),
                  label: '',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
