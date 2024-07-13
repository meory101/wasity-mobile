import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/features/home/widgets/home/button/category_icons.dart';
import 'package:wasity/features/home/widgets/home/button/view_all_bar.dart';
import 'package:wasity/features/home/widgets/home/container/new_arrivais_container.dart';
import 'package:wasity/features/home/widgets/home/container/offer.dart';
import 'package:wasity/features/home/widgets/home/container/trending_product.dart';
import 'package:wasity/features/home/widgets/home/form_field/search_form_field.dart';
import '../widgets/home/app_bar/main_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.navyBlue,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w5),
          child: Column(
            children: [
              MainAppBar(),
              SearchFormField(),
              Offer(),
              Categorys(),
              ViewAllBar(
                title: 'New Arrivals',
                onViewAllPressed: () {
                  Navigator.pushNamed(context, '/NewArrivais');
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NewArrivaisContainer(),
                  NewArrivaisContainer(),
                ],
              ),
              ViewAllBar(
                title: 'Trending Product',
                onViewAllPressed: () {
                  Navigator.pushNamed(context, '/TrendingProduct');
                },
              ),
              TrendingProductContainer(),
              TrendingProductContainer(),
              TrendingProductContainer(),
              Offer(),
              TrendingProductContainer(),
              TrendingProductContainer(),
              TrendingProductContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
