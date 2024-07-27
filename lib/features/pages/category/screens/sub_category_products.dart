import 'package:flutter/material.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
class SubCategoryProducts extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const SubCategoryProducts({super.key, required this.themeNotifier});


  @override
  State<SubCategoryProducts> createState() => _SubCategoryProductsState();
}

class _SubCategoryProductsState extends State<SubCategoryProducts> {
  @override
  Widget build(BuildContext context) {
    final String subCategories =
        ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SecondAppbar(
        onBack: () {
          Navigator.pop(context);
        },
        titleText: 'Subcategory for $subCategories',
      ),
    );
  }
}
