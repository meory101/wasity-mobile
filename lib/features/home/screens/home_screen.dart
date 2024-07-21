import 'package:flutter/material.dart';

import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/features/home/widgets/home/button/category_icons.dart';
import 'package:wasity/features/home/widgets/home/button/view_all_bar.dart';
import 'package:wasity/features/home/widgets/home/container/new_arrivais_container.dart';
import 'package:wasity/features/home/widgets/home/container/offer.dart';
import 'package:wasity/features/home/widgets/home/container/trending_product.dart';
import 'package:wasity/features/home/widgets/home/drawer/app_drawer.dart';
import 'package:wasity/features/home/widgets/home/form_field/search_form_field.dart';
import '../widgets/home/app_bar/main_app_bar.dart';


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
  @override
  Widget build(BuildContext context) {
  
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: AppDrawer(themeNotifier: widget.themeNotifier),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w5),
          child: Column(
            children: [
              MainAppBar(themeNotifier: widget.themeNotifier),
              SearchFormField(themeNotifier: widget.themeNotifier),
              Offer(themeNotifier: widget.themeNotifier),
              Categorys(themeNotifier: widget.themeNotifier),
              ViewAllBar(
                title: 'New Arrivals',
                onViewAllPressed: () {
                  Navigator.pushNamed(context, '/NewArrivais');
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NewArrivalsContainer(themeNotifier: widget.themeNotifier),
                  NewArrivalsContainer(themeNotifier: widget.themeNotifier),
                ],
              ),
              ViewAllBar(
                title: 'Trending Product',
                onViewAllPressed: () {
                  Navigator.pushNamed(context, '/TrendingProduct');
                },
              ),
              TrendingProductContainer(themeNotifier: widget.themeNotifier),
              TrendingProductContainer(themeNotifier: widget.themeNotifier),
              TrendingProductContainer(themeNotifier: widget.themeNotifier),
              Offer(themeNotifier: widget.themeNotifier),
              TrendingProductContainer(themeNotifier: widget.themeNotifier),
              TrendingProductContainer(themeNotifier: widget.themeNotifier),
              TrendingProductContainer(themeNotifier: widget.themeNotifier),
            ],
          ),
        ),
      ),
    );
  }
}
