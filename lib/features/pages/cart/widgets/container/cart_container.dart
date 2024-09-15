import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/text/price_text_widget.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:wasity/features/pages/cart/provider/cart_provider.dart';
import 'package:wasity/features/pages/cart/widgets/button/countity_selector.dart';

class CartContainer extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;
  final Product product;
  final VoidCallback onRemove;

  const CartContainer({
    super.key,
    required this.themeNotifier,
    required this.product,
    required this.onRemove,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CartContainerState createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
  int quantity = 1;

  @override
  void initState() {
    print(quantity);
    super.initState();
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    quantity = cartProvider.getQuantity(widget.product);
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
    Provider.of<CartProvider>(context, listen: false)
        .updateQuantity(widget.product, quantity);
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
      Provider.of<CartProvider>(context, listen: false)
          .updateQuantity(widget.product, quantity);
    }
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("تأكيد الحذف"),
          content:
              const Text("هل أنت متأكد من حذف هذا المنتج من سلة المشتريات؟"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text("إلغاء"),
            ),
            TextButton(
              onPressed: () {
                widget.onRemove(); 
                Navigator.of(context).pop(); 
              },
              child: const Text("تأكيد"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double unitPrice = widget.product.price;
    double totalPrice = unitPrice * quantity;

    return Padding(
      padding: EdgeInsets.only(bottom: AppHeightManager.h2),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadiusManager.r5),
                child: DecoratedContainer(
                  color: widget.themeNotifier.value == ThemeMode.dark
                      ? AppColorManager.navyLightBlue
                      : AppColorManager.whiteBlue,
                  width: AppWidthManager.w89,
                  height: AppHeightManager.h15point7,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: AppWidthManager.w3Point5,
                        top: AppHeightManager.h02,
                        bottom: AppHeightManager.h08),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppRadiusManager.r5),
                          child: DecoratedContainer(
                            width: AppWidthManager.w25,
                            height: AppHeightManager.h11,
                            child: InkWell(
                              child: Image.network(
                                '${Config.imageUrl}/${widget.product.image}',
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Image.asset(
                                      'assets/images/placeholder.png');
                                },
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/ProductInfo",
                                  arguments: widget.product,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: AppWidthManager.w3),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextWidget(
                                text: widget.product.name,
                                style: theme.textTheme.displayMedium?.copyWith(
                                  color: widget.themeNotifier.value ==
                                          ThemeMode.dark
                                      ? AppColorManager.white
                                      : AppColorManager.navyBlue,
                                ),
                              ),
                              SizedBox(height: AppHeightManager.h1point2),
                              AppTextWidget(
                                text: widget.product.desc,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: widget.themeNotifier.value ==
                                          ThemeMode.dark
                                      ? AppColorManager.grey
                                      : AppColorManager.navyBlue,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              SizedBox(height: AppHeightManager.h1point2),
                              // ?تحديث سعر المنتج بناءً على الكمية
                              PriceText(
                                price: totalPrice,
                                priceStyle:
                                    theme.textTheme.displayMedium?.copyWith(
                                  color: widget.themeNotifier.value ==
                                          ThemeMode.dark
                                      ? AppColorManager.white
                                      : AppColorManager.navyBlue,
                                ),
                                style: theme.textTheme.displayMedium?.copyWith(
                                  color: widget.themeNotifier.value ==
                                          ThemeMode.dark
                                      ? AppColorManager.white
                                      : AppColorManager.navyBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: AppWidthManager.w13,
                              top: AppHeightManager.h2,
                              bottom: AppHeightManager.h8),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: _showDeleteConfirmationDialog,
                                child: SvgPicture.asset(
                                  AppIconManager.trash,
                                  colorFilter: const ColorFilter.mode(
                                    AppColorManager.yellow,
                                    BlendMode.srcIn,
                                  ),
                                  width: AppWidthManager.w16,
                                  height: AppHeightManager.h3Point5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: AppWidthManager.w60,
                  right: AppWidthManager.w2,
                  top: AppHeightManager.h9,
                ),
                child: CountitySelector(
                  quantity: quantity,
                  onIncrement: _incrementQuantity,
                  onDecrement: _decrementQuantity,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
