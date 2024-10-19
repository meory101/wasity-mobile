import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:wasity/features/pages/cart/provider/cart_provider.dart';
import 'package:wasity/features/pages/cart/widgets/container/cart_container.dart';

class CartItemsWidget extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;
  final Function(Product product) onRemove;

  const CartItemsWidget({
    super.key,
    required this.themeNotifier,
    required this.onRemove,
  });

  @override
  State<CartItemsWidget> createState() => _CartItemsWidgetState();
}

class _CartItemsWidgetState extends State<CartItemsWidget> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        return CartContainer(
          themeNotifier: widget.themeNotifier,
          product: cartItems[index],
          onRemove: () => widget.onRemove(cartItems[index]),
        );
      },
    );
  }
}
