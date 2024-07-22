import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/router/router.dart';

class Wasity extends StatelessWidget {
  const Wasity({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return
        const MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: RouteNamedScreens.init,
        );
    });
  }
}
