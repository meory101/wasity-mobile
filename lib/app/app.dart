import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/router/router.dart';

class Wasity extends StatefulWidget {
  const Wasity({super.key});

  @override
  State<Wasity> createState() => _WasityState();
}

class _WasityState extends State<Wasity> {
@override
  void initState() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
    super.initState();
  }

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
