import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/features/models/appModels.dart';

class Categorys extends StatefulWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;
  const Categorys({super.key, this.themeNotifier});

  @override
  // ignore: library_private_types_in_public_api
  _CategorysState createState() => _CategorysState();
}

class _CategorysState extends State<Categorys> {
  late Future<List<MainCategory>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;
    final Color textColor =
        isDarkMode ? AppColorManager.white : AppColorManager.navyBlue;

    return FutureBuilder<List<MainCategory>>(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No categories available'));
        } else {
          final categories = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((category) {
                return Padding(
                  padding: EdgeInsets.only(right: AppWidthManager.w2),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/SubCategoryProducts',
                            arguments: {
                              'id': category.id,
                              'name': category.name,
                            },
                          );
                        },
                        child: DecoratedContainer(
                          width: AppWidthManager.w13point5,
                          height: AppHeightManager.h6point2,
                          borderRadius:
                              BorderRadius.circular(AppRadiusManager.r6),
                          image: DecorationImage(
                            image: NetworkImage(
                                'http://127.0.0.1:8000/storage/${category.image}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: AppHeightManager.h03),
                      AppTextWidget(
                        text: category.name,
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: textColor,
                                ),
                      ),
                      SizedBox(height: AppHeightManager.h5),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}

Future<List<MainCategory>> fetchCategories() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/api/getMainCatgories'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((category) => MainCategory.fromJson(category)).toList();
  } else {
    throw Exception('Failed to load categories');
  }
}
