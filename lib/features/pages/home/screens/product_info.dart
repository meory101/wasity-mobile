import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/text/price_text_widget.dart';
import 'package:wasity/features/models/appModels.dart';

class ProductInfo extends StatelessWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;
  final int productId;

  const ProductInfo({super.key, this.themeNotifier, required this.productId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = themeNotifier?.value == ThemeMode.dark;
    final textColor =
        isDarkMode ? AppColorManager.white : AppColorManager.navyBlue;

    
    final Product product = fetchProductById(productId);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: SecondAppbar(
        titleText: 'Product Info',
        onBack: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppWidthManager.w5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DecoratedContainer(
              width: double.infinity,
              height: AppHeightManager.h20,
              image: DecorationImage(
                image: NetworkImage(
                    'http://127.0.0.1:8000/storage/${product.image}'),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: AppHeightManager.h3),
            AppTextWidget(
              text: product.name,
              style: theme.textTheme.displayLarge?.copyWith(color: textColor),
            ),
            SizedBox(height: AppHeightManager.h1),
            // AppTextWidget(
            //   text: product.description ?? "No description available",
            //   style: theme.textTheme.displayMedium?.copyWith(color: textColor),
            // ),
            SizedBox(height: AppHeightManager.h1),
            PriceText(
              price: product.price,
              style: theme.textTheme.displayLarge?.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

Product fetchProductById(int id) {
  return Product(
    id: id,
    name: 'Product Name',
    // description: 'Product Description',
    image: 'path/to/image',
    price: 123.45,
    //  brand: , subCategory: ,
    // rating: 4.5,
  );
}
