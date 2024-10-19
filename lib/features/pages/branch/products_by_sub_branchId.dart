import 'package:flutter/material.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:wasity/features/pages/branch/widget/container/ProductsBySubBranchcontainer.dart';
import 'package:wasity/features/pages/home/widgets/form_field/search_form_field.dart';

class ProductsBySubBranchid extends StatelessWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;
  final int subBranchId;

  const ProductsBySubBranchid(
      {super.key, this.themeNotifier, required this.subBranchId});

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
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
        child: FutureBuilder<List<Product>>(
          future: fetchProductsBySubBranchId(subBranchId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final products = snapshot.data!;
              return Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SearchFormField(),
                  SizedBox(height: AppHeightManager.h3),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: AppWidthManager.w4,
                        childAspectRatio:
                            (AppWidthManager.w27 / AppHeightManager.h23),
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Productsbysubbranchcontainer(
                          themeNotifier: themeNotifier,
                          product: product,
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                  child: AppTextWidget(text: 'No products available'));
            }
          },
        ),
      ),
    );
  }
}
