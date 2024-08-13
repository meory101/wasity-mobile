import 'package:flutter/material.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/Drawer/app_drawer.dart';
import 'package:wasity/features/pages/category/widgets/button/category_icons.dart';
import 'package:wasity/features/pages/home/widgets/button/view_all_bar.dart';
import 'package:wasity/features/pages/home/widgets/containers/brand.dart';
import 'package:wasity/features/pages/home/widgets/containers/new_arrivais_container.dart';
import 'package:wasity/features/pages/home/widgets/containers/offer.dart';
import 'package:wasity/features/pages/home/widgets/containers/trending_product.dart';
import 'package:wasity/features/pages/home/widgets/form_field/search_form_field.dart';
import '../widgets/app_bar/main_app_bar.dart';
import 'package:wasity/features/models/appModels.dart'; 
import 'package:wasity/features/api/api_link.dart'; 

class HomeScreen extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const HomeScreen({
    super.key,
    required this.themeNotifier,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<NewArrivaisData>> _futureNewArrivals;

  @override
  void initState() {
    super.initState();
    _futureNewArrivals = fetchNewArrivais(); 
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      drawer: AppDrawer(themeNotifier: widget.themeNotifier),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainAppBar(themeNotifier: widget.themeNotifier),
              SearchFormField(themeNotifier: widget.themeNotifier),
           const BrandList(),
              Categorys(themeNotifier: widget.themeNotifier),
              ViewAllBar(
                title: 'New Arrivals',
                onViewAllPressed: () {
                  Navigator.pushNamed(context, '/NewArrivais');
                },
              ),
              FutureBuilder<List<NewArrivaisData>>(
                future: _futureNewArrivals,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No new arrivals found'));
                  }

                  final newArrivalsList = snapshot.data!
                      .expand((data) => data.newItems)
                      .toList();

                 
                  final randomItems = (newArrivalsList..shuffle()).take(2).toList();

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: randomItems.map((item) {
                      return Expanded(
                        child: NewArrivaisContainer(
                          themeNotifier: widget.themeNotifier,
                          newItem: item,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              ViewAllBar(
                title: 'Trending Product',
                onViewAllPressed: () {
                  Navigator.pushNamed(context, '/TrendingProduct');
                },
              ),
              Column(
                children: List.generate(
                  3,
                  (index) => TrendingProductContainer(
                    themeNotifier: widget.themeNotifier,
                  ),
                ),
              ),
              ViewAllBar(
                title: 'Brands',
                onViewAllPressed: () {
                  // Navigator.pushNamed(context, '/BrandsPage');
                },
              ),
             
                  Offer(themeNotifier: widget.themeNotifier),
            ],
          ),
        ),
      ),
    );
  }
}
