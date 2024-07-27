import 'package:flutter/material.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/features/pages/cart/container/cart_container.dart';

import '../../../../core/resource/size_manager.dart';

class Cart extends StatefulWidget {
  const Cart({super.key, required this.themeNotifier});

  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SecondAppbar(
        onBack: () {
          Navigator.pop(context);
        },
        titleText: "Your Cart",
      ),
      body: Padding(
        padding:
            EdgeInsets.only(left: AppWidthManager.w5, top: AppHeightManager.h3),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CartContainer(themeNotifier: widget.themeNotifier),
              CartContainer(themeNotifier: widget.themeNotifier),
              CartContainer(themeNotifier: widget.themeNotifier),
              CartContainer(themeNotifier: widget.themeNotifier),
              CartContainer(themeNotifier: widget.themeNotifier),
            ],
          ),
        ),
      ),
    );
  }
}
