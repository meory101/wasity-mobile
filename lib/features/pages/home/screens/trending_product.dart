import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:wasity/features/pages/home/widgets/containers/trending_product.dart';

class TrendingProduct extends StatefulWidget {
  final ValueNotifier<ThemeMode>? themeNotifier;

  const TrendingProduct({super.key, this.themeNotifier});

  @override
  State<TrendingProduct> createState() => _TrendingProductState();
}

class _TrendingProductState extends State<TrendingProduct> {
  late Future<List<Product>> trendingProducts;

  @override
  void initState() {
    super.initState();
    trendingProducts = TrendingProductService().fetchTrendingProducts();
  }

  Future<void> _refreshTrendingProducts() async {
    setState(() {
      trendingProducts = TrendingProductService().fetchTrendingProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: SecondAppbar(
        onBack: () => Navigator.pop(context),
        titleText: "Trending Products",
      ),
      body: RefreshIndicator(
        onRefresh: _refreshTrendingProducts,
        child: FutureBuilder<List<Product>>(
          future: trendingProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                  child: AppTextWidget(text: 'Failed to load products'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: AppTextWidget(text: 'No trending products available'));
            } else {
              final products = snapshot.data!;
              return Semantics(
                label: 'قائمة المنتجات الرائجة',
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    try {
                      return Semantics(
                        label: 'المنتج ${products[index].name}',
                        hint: 'اضغط للحصول على معلومات المنتج',
                        child: TrendingProductContainer(
                          themeNotifier: widget.themeNotifier,
                          product: products[index],
                        ),
                      );
                    } catch (e) {
                      if (kDebugMode) {
                        print('Error building item at index $index: $e');
                      }
                      return Container();
                    }
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
