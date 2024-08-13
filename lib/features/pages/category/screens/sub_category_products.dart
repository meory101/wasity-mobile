import 'package:flutter/material.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:wasity/features/pages/category/screens/Products_by_sub_category.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';

class SubCategoryProducts extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const SubCategoryProducts({super.key, required this.themeNotifier});

  @override
  State<SubCategoryProducts> createState() => _SubCategoryProductsState();
}

class _SubCategoryProductsState extends State<SubCategoryProducts> {
  late Future<List<MainCategory>> futureSubCategories;
  late String mainCategoryName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int mainCategoryId = arguments['id'];
    mainCategoryName = arguments['name'];
    futureSubCategories = fetchSubCategories(mainCategoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SecondAppbar(
        onBack: () {
          Navigator.pop(context);
        },
        titleText: 'Subcategory for $mainCategoryName',
      ),
      body: FutureBuilder<List<MainCategory>>(
        future: futureSubCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No subcategories available'));
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
                  childAspectRatio:
                      (AppWidthManager.w25 / AppHeightManager.h14),
                ),
                itemCount: subCategories.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductsBySubCategory(
                                themeNotifier: widget.themeNotifier,
                                subCategoryId: subCategories[index].id,
                              ),
                            ),
                          );
                        },
                        child: DecoratedContainer(
                          width: AppWidthManager.w25,
                          height: AppHeightManager.h11,
                          borderRadius:
                              BorderRadius.circular(AppRadiusManager.r6),
                          image: DecorationImage(
                            image: NetworkImage(
                                'http://127.0.0.1:8000/storage/${subCategories[index].image}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: AppHeightManager.h1point5),
                      AppTextWidget(
                        text: subCategories[index].name,
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
