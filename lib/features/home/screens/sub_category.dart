import 'package:flutter/material.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class SubcategoryPage extends StatelessWidget {
  final List<String> subCategories = [
    "subCategorie1",
    "subCategorie2",
    "subCategorie3",
    "subCategorie4",
    "subCategorie5",
    "subCategorie6",
    "subCategorie7",
    "subCategorie8",
    "subCategorie9",
    "subCategorie10",
    "subCategorie11",
    "subCategorie12",
    "subCategorie13",
    "subCategorie14",
    "subCategorie15",
  ];

  final ValueNotifier<ThemeMode> themeNotifier;

  SubcategoryPage({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    final String mainCategory =
        ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SecondAppbar(
        onBack: () {
          Navigator.pop(context);
        },
        titleText: 'Subcategory for $mainCategory',
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: AppWidthManager.w4,
            right: AppWidthManager.w4,
            top: AppHeightManager.h4),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: AppHeightManager.h2,
            crossAxisSpacing: AppWidthManager.w2,
            childAspectRatio: (AppWidthManager.w25 / AppHeightManager.h14),
          ),
          itemCount: subCategories.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/SubCategoryProducts',
                      arguments: subCategories[index],
                    );
                  },
                  child: DecoratedContainer(
                    width: AppWidthManager.w25,
                    height: AppHeightManager.h11,
                    borderRadius: BorderRadius.circular(AppRadiusManager.r6),
                    image: DecorationImage(
                      image: AssetImage(AppImageManager.subCategoryImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: AppHeightManager.h1point5),
                AppTextWidget(
                  text: subCategories[index],
                  height: AppHeightManager.h03,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
