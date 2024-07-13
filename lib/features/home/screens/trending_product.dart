import 'package:flutter/cupertino.dart';

class TrendingProduct extends StatefulWidget {
  const TrendingProduct({super.key});

  @override
  State<TrendingProduct> createState() => _TrendingProductState();
}

class _TrendingProductState extends State<TrendingProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("data"),
      ),
    );
  }
}
