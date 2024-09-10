// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:wasity/features/pages/category/widgets/containers/ProductsBySubCategory.dart';
import 'package:wasity/features/pages/home/widgets/form_field/search_form_field.dart';
class ProductsBySubCategory extends StatefulWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;
  final int subCategoryId;
  final int mainCategoryId; 

  const ProductsBySubCategory({
    super.key,
    this.themeNotifier,
    required this.subCategoryId,
    required this.mainCategoryId, 
  });

  @override
  // ignore: library_private_types_in_public_api
  __ProductsBySubCategoryState createState() => __ProductsBySubCategoryState();
}

class __ProductsBySubCategoryState extends State<ProductsBySubCategory> {
  late Future<List<Product>> futureProducts;
  final ProductService productService = ProductService();

  @override
  void initState() {
    super.initState();
    futureProducts = productService.fetchProductsBySubCategoryId(widget.subCategoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SecondAppbar(
        onBack: () {
          Navigator.pop(context);
        },
        titleText: "Products",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppWidthManager.w5Point3,
            vertical: AppHeightManager.h3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SearchFormField(),
            SizedBox(height: AppHeightManager.h3),
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No products available'));
                  } else {
                    final products = snapshot.data!;
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: AppWidthManager.w3,
                        childAspectRatio: (AppWidthManager.w25 / AppHeightManager.h23),
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductsbysubcategoryContainer(
                          themeNotifier: widget.themeNotifier,
                          product: products[index],
                         
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
