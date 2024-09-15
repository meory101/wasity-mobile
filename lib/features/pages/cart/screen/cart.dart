import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/button/app_button.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/text/price_text_widget.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:wasity/features/pages/cart/provider/cart_provider.dart';
import 'package:wasity/features/pages/cart/widgets/cartItemsList/cart_list.dart';

class Cart extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;
  final Address? selectedAddress;

  const Cart({
    super.key,
    required this.themeNotifier,
    this.selectedAddress,
  });

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  void _removeItem(Product product) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.removeFromCart(product);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SecondAppbar(
        onBack: () => Navigator.pushNamed(context, '/ButtonNavbar'),
        titleText: "Your Cart",
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: AppWidthManager.w5,
              top: AppHeightManager.h3,
            ),
            child: CartItemsWidget(
              themeNotifier: widget.themeNotifier,
              onRemove: _removeItem,
            ),
          ),
          if (widget.selectedAddress != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Selected Address: ${widget.selectedAddress!.name}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: FontSizeManager.fs17,
                ),
              ),
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DecoratedContainer(
                height: AppHeightManager.h10,
                color: AppColorManager.navyLightBlue,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: AppWidthManager.w48,
                    top: AppHeightManager.h1point5,
                    bottom: AppHeightManager.h1point8,
                    right: AppWidthManager.w5,
                  ),
                  child: AppElevatedButton(
                    text: "Checkout",
                    color: AppColorManager.white,
                    onPressed: () {
                      Navigator.pushNamed(context, '/Checkout');
                    },
                    textColor: AppColorManager.navyBlue,
                    fontSize: FontSizeManager.fs17,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 55),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppTextWidget(
                  text: "Total price",
                  color: AppColorManager.lightGrey,
                  fontSize: FontSizeManager.fs18,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return PriceText(
                      price: cartProvider.totalPrice,
                      priceStyle: theme.textTheme.displayLarge,
                      style: theme.textTheme.displayMedium,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
