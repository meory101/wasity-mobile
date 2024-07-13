import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';

class SubCategoryProducts extends StatefulWidget {
  const SubCategoryProducts({super.key});

  @override
  State<SubCategoryProducts> createState() => _SubCategoryProductsState();
}

class _SubCategoryProductsState extends State<SubCategoryProducts> {
  @override
  Widget build(BuildContext context) {
    final String subCategories =
        ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      backgroundColor: AppColorManager.navyBlue,
      appBar: SecondAppbar(
        onBack: () {
          Navigator.pop(context);
        },
        titleText: 'Subcategory for $subCategories',
      ),
    );
  }
}
