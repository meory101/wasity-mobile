import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wasity/core/resource/size_manager.dart';

class Wasity extends StatelessWidget {
  const Wasity({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return
        MaterialApp(
          home:Scaffold(
            body: Container(
              height: AppHeightManager.h3Point5,
              // width: ,
            ),
          ),
        );
    });
  }
}
