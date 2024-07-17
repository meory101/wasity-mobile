import 'package:flutter/cupertino.dart';
// ignore: implementation_imports
import 'package:flutter/src/material/app.dart';

class TrendingProduct extends StatefulWidget {
  const TrendingProduct({super.key, required ValueNotifier<ThemeMode> themeNotifier});

  @override
  State<TrendingProduct> createState() => _TrendingProductState();
}

class _TrendingProductState extends State<TrendingProduct> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("data"),
    );
  }
}
