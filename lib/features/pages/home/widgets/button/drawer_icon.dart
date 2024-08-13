import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasity/core/resource/icon_manager.dart';

class DrawerIcon extends StatelessWidget {
  const DrawerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        AppIconManager.list,
        // ignore: deprecated_member_use
        color: Theme.of(context).textTheme.bodyLarge?.color
        
        ,

      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}
