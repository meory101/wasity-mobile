import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:wasity/features/pages/cart/provider/cart_provider.dart';

class CartButton extends StatelessWidget {
  final Product product;

  const CartButton({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final containerColor =
        isDarkMode ? AppColorManager.whiteBlue : AppColorManager.navyBlue;
    final iconColor =
        isDarkMode ? AppColorManager.grayLightBlue : AppColorManager.white;

    return InkWell(
      onTap: () {
        final cartProvider = Provider.of<CartProvider>(context, listen: false);
        cartProvider.addToCart(product);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.name} has been added to your cart!'),
          ),
        );
      },
      child: Semantics(
        label: ' اضافة للسلة',
        child: DecoratedContainer(
          borderRadius: BorderRadius.circular(AppRadiusManager.r4),
          shape: BoxShape.circle,
          width: AppWidthManager.w8point5,
          height: AppHeightManager.h8,
          color: containerColor,
          child: SvgPicture.asset(
            fit: BoxFit.scaleDown,
            AppIconManager.cartFill,
            colorFilter: ColorFilter.mode(
              iconColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
