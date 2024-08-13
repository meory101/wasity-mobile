import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/features/pages/cart/screen/cart.dart';
import 'package:wasity/features/pages/category/screens/all_category.dart';
import 'package:wasity/features/pages/home/screens/home_screen.dart';
import 'package:wasity/features/pages/profile/screens/profile_info.dart';

class ButtonNavbar extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const ButtonNavbar({super.key, required this.themeNotifier});

  @override
  // ignore: library_private_types_in_public_api
  _ButtonNavbarState createState() => _ButtonNavbarState();
}

class _ButtonNavbarState extends State<ButtonNavbar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomeScreen(themeNotifier: widget.themeNotifier),
      AllCategory(themeNotifier: widget.themeNotifier),
      Cart(themeNotifier: widget.themeNotifier),
      ProfileInfo(themeNotifier: widget.themeNotifier),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: _selectedIndex == 2
          ? null
          : ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppRadiusManager.r10),
                topRight: Radius.circular(AppRadiusManager.r10),
              ),
              child: DecoratedContainer(
                child: NavigationBar(
                  selectedIndex: _selectedIndex,
                  elevation: 0,
                  indicatorColor: AppColorManager.yellow,
                  height: AppHeightManager.h9,
                  backgroundColor: AppColorManager.navyLightBlue,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
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
