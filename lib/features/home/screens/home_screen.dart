<<<<<<< HEAD
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/features/home/widgets/home/container/category_icons.dart';
import 'package:wasity/features/home/widgets/home/container/offer.dart';
import 'package:wasity/features/home/widgets/home/form_field/search_form_field.dart';
import '../widgets/home/app_bar/home_app_bar.dart';
=======
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/home_app_bar.dart';
>>>>>>> origin/ahmad

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
      backgroundColor: AppColorManager.navyBlue,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w5Point3),
          child: Column(
            children: [
              HomeAppBar(),
              SearchFormField(),
              Offer(),
              Categorys(),
            ],
          ),
=======
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeAppBar()
          ],
>>>>>>> origin/ahmad
        ),
      ),
    );
  }
}
