import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/button/app_button.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/text/price_text_widget.dart';
import 'package:wasity/features/pages/cart/widgets/container/cart_container.dart';
import 'package:wasity/core/resource/size_manager.dart';

class Cart extends StatefulWidget {
  const Cart({super.key, required this.themeNotifier});

  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SecondAppbar(
        onBack: () => Navigator.pushNamed(context, '/ButtonNavbar'),
        titleText: "Your Cart",
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppWidthManager.w5,
            top: AppHeightManager.h3,
          ),
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return CartContainer(themeNotifier: widget.themeNotifier);
            },
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DecoratedContainer(
              height: AppHeightManager.h12,
              color: AppColorManager.navyLightBlue,
              child: Padding(
                padding: EdgeInsets.only(
                    left: AppWidthManager.w50,
                    top: AppHeightManager.h1point8,
                    bottom: AppHeightManager.h1point8,
                    right: AppWidthManager.w6),
                child: AppElevatedButton(
                  text: "Checkout",
                  color: AppColorManager.white,
                  onPressed: () {},
                  textColor: AppColorManager.navyBlue,
                  fontSize: FontSizeManager.fs17,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 40),
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
              PriceText(
                  price: 2300000,
                  priceStyle: theme.textTheme.displayLarge,
                  style: theme.textTheme.displayMedium),
            ],
          ),
        ),
      ]),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:wasity/core/resource/color_manager.dart';
// import 'package:wasity/core/resource/font_manager.dart';
// import 'package:wasity/core/widget/app_bar/second_appbar.dart';
// import 'package:wasity/core/widget/button/app_button.dart';
// import 'package:wasity/core/widget/container/decorated_container.dart';
// import 'package:wasity/core/widget/text/app_text_widget.dart';
// import 'package:wasity/core/widget/text/price_text_widget.dart';
// import 'package:wasity/features/pages/cart/widgets/container/cart_container.dart';
// import 'package:wasity/core/resource/size_manager.dart';
// class Cart extends StatefulWidget {
//   const Cart({super.key, required this.themeNotifier});

//   final ValueNotifier<ThemeMode> themeNotifier;

//   @override
//   State<Cart> createState() => _CartState();
// }

// class _CartState extends State<Cart> {
//   List<Map<String, dynamic>> cartItems = [
//     {"productName": "Product 1", "unitPrice": 123.45, "quantity": 1},
//     {"productName": "Product 2", "unitPrice": 150.75, "quantity": 1},
//     {"productName": "Product 3", "unitPrice": 99.99, "quantity": 1},
//     {"productName": "Product 4", "unitPrice": 200.50, "quantity": 1},
//   ];

//   double totalCartPrice = 0;

//   @override
//   void initState() {
//     super.initState();
//     _calculateTotalPrice();
//   }

//   void _calculateTotalPrice() {
//     totalCartPrice = cartItems.fold(
//       0,
//       (sum, item) => sum + item['unitPrice'] * item['quantity'],
//     );
//   }

//   void _updateTotalPrice(double change) {
//     setState(() {
//       totalCartPrice += change;
//     });
//   }

//   void _removeItem(int index) {
//     setState(() {
//       double itemTotalPrice = cartItems[index]['unitPrice'] * cartItems[index]['quantity'];
//       _updateTotalPrice(-itemTotalPrice);
//       cartItems.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     ThemeData theme = Theme.of(context);
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: SecondAppbar(
//         onBack: () => Navigator.pushNamed(context, '/ButtonNavbar'),
//         titleText: "Your Cart",
//       ),
//       body: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//               left: AppWidthManager.w5,
//               top: AppHeightManager.h3,
//             ),
//             child: ListView.builder(
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 return CartContainer(
//                   themeNotifier: widget.themeNotifier,
//                   onTotalPriceChanged: _updateTotalPrice,
//                   onRemove: () => _removeItem(index),
//                 );
//               },
//             ),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               DecoratedContainer(
//                 height: AppHeightManager.h12,
//                 color: AppColorManager.navyLightBlue,
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                       left: AppWidthManager.w50,
//                       top: AppHeightManager.h1point8,
//                       bottom: AppHeightManager.h1point8,
//                       right: AppWidthManager.w6),
//                   child: AppElevatedButton(
//                     text: "Checkout",
//                     color: AppColorManager.white,
//                     onPressed: () {},
//                     textColor: AppColorManager.navyBlue,
//                     fontSize: FontSizeManager.fs17,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 15, bottom: 40),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 AppTextWidget(
//                   text: "Total price",
//                   color: AppColorManager.lightGrey,
//                   fontSize: FontSizeManager.fs18,
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 15, bottom: 20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 PriceText(
//                   price: totalCartPrice,
//                   priceStyle: theme.textTheme.displayLarge,
//                   style: theme.textTheme.displayMedium,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
