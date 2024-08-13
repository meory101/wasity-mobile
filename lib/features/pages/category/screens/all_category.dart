import 'package:flutter/material.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/models/appModels.dart';

class AllCategory extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const AllCategory({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SecondAppbar(
        titleText: 'All Category',
        onBack: () {  
          Navigator.pushNamed(context, '/ButtonNavbar'); 
        },
      ),
      body: FutureBuilder<List<SubCategory>>(
        future: fetchMainCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final subCategories = snapshot.data!;
            return Padding(
              padding: EdgeInsets.only(
                left: AppWidthManager.w4,
                right: AppWidthManager.w4,
                top: AppHeightManager.h4,
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: AppHeightManager.h2,
                  crossAxisSpacing: AppWidthManager.w2,
                  childAspectRatio: (AppWidthManager.w25 / AppHeightManager.h14),
                ),
                itemCount: subCategories.length,
                itemBuilder: (context, index) {
                  final subCategory = subCategories[index];
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/SubCategoryProducts',
                            arguments: {
                              'id': subCategory.id,
                              'name': subCategory.name,
                            },
                          );
                        },
                        child: DecoratedContainer(
                          width: AppWidthManager.w25,
                          height: AppHeightManager.h11,
                          borderRadius: BorderRadius.circular(AppRadiusManager.r6),
                          image: DecorationImage(
                            image: NetworkImage(
                                'http://127.0.0.1:8000/storage/${subCategory.image}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: AppHeightManager.h1point5),
                      AppTextWidget(
                        text: subCategory.name,
                        height: AppHeightManager.h03,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
