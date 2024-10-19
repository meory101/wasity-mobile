import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/storage/shared/shared_pref.dart';
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
  Future<void> _refreshCart() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.loadCartItems();
  }

  void _removeItem(Product product) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.removeFromCart(product);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: _refreshCart,
      child: Scaffold(
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
              child: Semantics(
                label: 'المنتجات في سلتك',
                hint:
                    'مرر لليسار +أو اليمين لاستعراض العناصر الموجودة في عربة التسوق الخاصة بك',
                child: CartItemsWidget(
                  themeNotifier: widget.themeNotifier,
                  onRemove: _removeItem,
                ),
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
                Semantics(
                  label: 'زر الانتقال للطلب',
                  child: DecoratedContainer(
                    height: AppHeightManager.h10,
                    color: AppColorManager.navyLightBlue,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: AppWidthManager.w48,
                        top: AppHeightManager.h1point5,
                        bottom: AppHeightManager.h1point8,
                        right: AppWidthManager.w5,
                      ),
                      child: Semantics(
                        child: AppElevatedButton(
                          text: "Checkout",
                          color: AppColorManager.white,
                          onPressed: () {
                            final cartProvider = Provider.of<CartProvider>(
                                context,
                                listen: false);
                            bool hasEnoughStock = true;
                            String message = "";

                            for (var entry in cartProvider.products.entries) {
                              int productId = entry.key;
                              int requestedQuantity = entry.value;
                              Product product = cartProvider.cartItems
                                  .firstWhere((p) => p.id == productId);
                              int availableQuantity = product.procountity;

                              if (requestedQuantity > availableQuantity) {
                                hasEnoughStock = false;
                                message +=
                                    "الكمية المطلوبة ($requestedQuantity) للمنتج ${product.name} تتجاوز الكمية المتوفرة ($availableQuantity)\n";
                              }
                            }

                            // Check points
                            int userPoints = AppSharedPreferences.getPoints();
                            if (userPoints <= 100) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: AppColorManager.shadow2,
                                    title: Semantics(
                                      child: AppTextWidget(
                                        text: "نقاط غير كافية",
                                        color: AppColorManager.red,
                                        fontSize: FontSizeManager.fs20,
                                      ),
                                    ),
                                    content: Semantics(
                                      child: AppTextWidget(
                                        fontSize: FontSizeManager.fs16point5,
                                        text:
                                            "يجب أن تكون نقاطك أكثر من 100\n للانتقال إلى صفحة الدفع.",
                                        color: AppColorManager.white,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Semantics(
                                        label: 'زر ok',
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: AppTextWidget(
                                            text: "Ok",
                                            color: AppColorManager.white,
                                            fontSize:
                                                FontSizeManager.fs16point5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                              return;
                            }

                            if (hasEnoughStock) {
                              Navigator.pushNamed(context, '/Checkout');
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: AppColorManager.grey,
                                    title: Semantics(
                                      child: const Text(
                                        "كمية غير كافية",
                                        style: TextStyle(
                                            color: AppColorManager.red),
                                      ),
                                    ),
                                    content: Semantics(
                                      child: Text(
                                        message,
                                        style: const TextStyle(
                                          color: AppColorManager.white,
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Semantics(
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("موافق"),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          textColor: AppColorManager.navyBlue,
                          fontSize: FontSizeManager.fs17,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Semantics(
              label: 'السعر الكلي للمنتجات',
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: AppHeightManager.h1point5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppTextWidget(
                            text: "Total price",
                            color: AppColorManager.lightGrey,
                            fontSize: FontSizeManager.fs18,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: AppWidthManager.w5,
                              top: AppHeightManager.h05,
                              bottom: AppHeightManager.h1,
                            ),
                            child: Consumer<CartProvider>(
                              builder: (context, cartProvider, child) {
                                return PriceText(
                                  price: cartProvider.totalPrice,
                                  priceStyle: theme.textTheme.displayLarge,
                                  style: theme.textTheme.displayMedium,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
