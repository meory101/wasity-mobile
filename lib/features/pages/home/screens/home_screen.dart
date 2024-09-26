import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/Drawer/app_drawer.dart';
import 'package:wasity/features/pages/category/widgets/containers/category_icons.dart';
import 'package:wasity/features/pages/home/widgets/button/view_all_bar.dart';
import 'package:wasity/features/pages/home/widgets/containers/brand.dart';
import 'package:wasity/features/pages/home/widgets/containers/new_arrivais_container.dart';
import 'package:wasity/features/pages/home/widgets/containers/trending_product.dart';
// import 'package:wasity/features/pages/home/widgets/containers/trending_product.dart';
import 'package:wasity/features/pages/home/widgets/form_field/search_form_field.dart';
import '../widgets/app_bar/main_app_bar.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:wasity/features/api/api_link.dart';

TextEditingController irSearch = TextEditingController();

class HomeScreen extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;
  final Product? product;

  const HomeScreen({
    super.key,
    required this.themeNotifier,
    this.product,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> _futureNewArrivals;
  late Future<List<Product>> _futureTrendingProducts;

  @override
  void initState() {
    super.initState();
    _futureNewArrivals = fetchNewItems();
    _futureTrendingProducts = TrendingProductService().fetchTrendingProducts();
  }

  Future<void> _refreshData() async {
    setState(() {
      _futureNewArrivals = fetchNewItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      drawer: AppDrawer(themeNotifier: widget.themeNotifier),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainAppBar(themeNotifier: widget.themeNotifier),
                SearchFormField(
                  themeNotifier: widget.themeNotifier,
                  searchController: irSearch,
                ),
                const ViewAllBar(
                  title: 'Brands',
                ),
                const BrandList(),
                Categorys(themeNotifier: widget.themeNotifier),
                ViewAllBar(
                  viewAllText: 'View All',
                  title: 'New Arrivals',
                  onViewAllPressed: () {
                    Navigator.pushNamed(context, '/NewArrivais');
                  },
                ),
                FutureBuilder<List<Product>>(
                  future: _futureNewArrivals,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No new arrivals found'));
                    }
                    final newArrivalsList = snapshot.data!;
                    final lastFourItems = newArrivalsList.takeLast(4).toList();
                    final firstRowItems = lastFourItems.take(2).toList();
                    final secondRowItems = lastFourItems.skip(2).toList();

                    return Column(
                      children: [
                        Row(
                          children: firstRowItems.map((product) {
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppHeightManager.h1point3),
                                child: NewArrivaisContainer(
                                  themeNotifier: widget.themeNotifier,
                                  product: product,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: AppHeightManager.h02),
                        Row(
                          children: secondRowItems.map((product) {
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppHeightManager.h1point3),
                                child: NewArrivaisContainer(
                                  themeNotifier: widget.themeNotifier,
                                  product: product,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  },
                ),
                ViewAllBar(
                  viewAllText: 'View All',
                  title: 'Trending Product',
                  onViewAllPressed: () {
                    Navigator.pushNamed(context, '/TrendingProduct');
                  },
                ),
                FutureBuilder<List<Product>>(
                  future: _futureTrendingProducts,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No trending products found'));
                    }

                    final products = snapshot.data!;

                    return Column(
                      children: List.generate(
                        products.length,
                        (index) => TrendingProductContainer(
                          themeNotifier: widget.themeNotifier,
                          product: products[index],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension ListTakeLast<T> on List<T> {
  List<T> takeLast(int count) {
    if (count >= length) return this;
    return sublist(length - count);
  }
}
