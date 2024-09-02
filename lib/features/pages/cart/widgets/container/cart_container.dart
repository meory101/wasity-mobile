import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/text/price_text_widget.dart';

class CartContainer extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const CartContainer({super.key, required this.themeNotifier});

  @override
  // ignore: library_private_types_in_public_api
  _CartContainerState createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
  int quantity = 1;
  double unitPrice = 123.45;

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
                              child: Image.asset(
                                AppImageManager.productImage,
                                fit: BoxFit.cover,
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/ProductInfo",
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: AppWidthManager.w3,
                              top: AppHeightManager.h2point2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextWidget(
                                text: "Product Name",
                                style: theme.textTheme.displayMedium?.copyWith(
                                  color: widget.themeNotifier.value ==
                                          ThemeMode.dark
                                      ? AppColorManager.white
                                      : AppColorManager.navyBlue,
                                ),
                              ),
                              AppTextWidget(
                                text: "Product description",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: widget.themeNotifier.value ==
                                          ThemeMode.dark
                                      ? AppColorManager.grey
                                      : AppColorManager.navyBlue,
                                ),
                              ),
                              SizedBox(
                                height: AppHeightManager.h1point2,
                              ),
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
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    AppIconManager.trash,
                                    colorFilter: const ColorFilter.mode(
                                      AppColorManager.yellow,
                                      BlendMode.srcIn,
                                    ),
                                    width: AppWidthManager.w16,
                                    height: AppHeightManager.h3Point5,
                                  ),
                                ],
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
                  child: DecoratedContainer(
                    color: AppColorManager.navyBlue,
                    width: AppWidthManager.w26,
                    height: AppHeightManager.h4point4,
                    child: Row(
                      children: [
                        SizedBox(
                          width: AppWidthManager.w1,
                        ),
                        GestureDetector(
                          onTap: _decrementQuantity,
                          child: DecoratedContainer(
                            color: AppColorManager.whiteBlue,
                            height: AppHeightManager.h3point3,
                            width: AppWidthManager.w7,
                            child: Center(
                              child: SvgPicture.asset(
                                width: AppWidthManager.w4,
                                AppIconManager.minimize,
                                // ignore: deprecated_member_use
                                color: AppColorManager.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: AppWidthManager.w10,
                          child: Center(
                              child: AppTextWidget(
                            text: '$quantity',
                            fontSize: FontSizeManager.fs17,
                          )),
                        ),
                          GestureDetector(
                            onTap: _incrementQuantity,
                            child: DecoratedContainer(
                              color: AppColorManager.navyLightBlue,
                              height: AppHeightManager.h3point3,
                              width: AppWidthManager.w7,
                              child: Center(
                                child: SvgPicture.asset(
                                  width: AppWidthManager.w4,
                                  AppIconManager.add,
                                ),
                              ),
                            ),
                          ),
                        SizedBox(
                          width: AppWidthManager.w1,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// // ignore: depend_on_referenced_packages
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:wasity/core/resource/color_manager.dart';
// import 'package:wasity/core/resource/font_manager.dart';
// import 'package:wasity/core/resource/icon_manager.dart';
// import 'package:wasity/core/resource/image_manager.dart';
// import 'package:wasity/core/resource/size_manager.dart';
// import 'package:wasity/core/widget/container/decorated_container.dart';
// import 'package:wasity/core/widget/text/app_text_widget.dart';
// import 'package:wasity/core/widget/text/price_text_widget.dart';

// class CartContainer extends StatefulWidget {
//   final ValueNotifier<ThemeMode> themeNotifier;
//   final Function(double) onTotalPriceChanged;
//   final Function() onRemove;

//   const CartContainer({
//     super.key,
//     required this.themeNotifier,
//     required this.onTotalPriceChanged,
//     required this.onRemove,
//   });

//   @override
//   _CartContainerState createState() => _CartContainerState();
// }

// class _CartContainerState extends State<CartContainer> {
//   int quantity = 1;
//   double unitPrice = 20000;

//   void _incrementQuantity() {
//     setState(() {
//       quantity++;
//       widget.onTotalPriceChanged(unitPrice);
//     });
//   }

//   void _decrementQuantity() {
//     if (quantity > 1) {
//       setState(() {
//         quantity--;
//         widget.onTotalPriceChanged(-unitPrice);
//       });
//     }
//   }

//   void _confirmRemoveProduct() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Confirm Removal'),
//         content: const Text(
//             'Are you sure you want to remove this item from your cart?'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               widget.onRemove();
//               widget.onTotalPriceChanged(-unitPrice * quantity);
//             },
//             child: const Text('Remove'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     ThemeData theme = Theme.of(context);
//     double totalPrice = unitPrice * quantity;

//     return Padding(
//       padding: EdgeInsets.only(bottom: AppHeightManager.h2),
//       child: Row(
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(AppRadiusManager.r5),
//                 child: DecoratedContainer(
//                   color: widget.themeNotifier.value == ThemeMode.dark
//                       ? AppColorManager.navyLightBlue
//                       : AppColorManager.whiteBlue,
//                   width: AppWidthManager.w89,
//                   height: AppHeightManager.h15point7,
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                         left: AppWidthManager.w3Point5,
//                         top: AppHeightManager.h02,
//                         bottom: AppHeightManager.h08),
//                     child: Row(
//                       children: [
//                         // صورة المنتج
//                         ClipRRect(
//                           borderRadius:
//                               BorderRadius.circular(AppRadiusManager.r5),
//                           child: DecoratedContainer(
//                             width: AppWidthManager.w25,
//                             height: AppHeightManager.h11,
//                             child: InkWell(
//                               child: Image.asset(
//                                 AppImageManager.productImage,
//                                 fit: BoxFit.cover,
//                               ),
//                               onTap: () {
//                                 Navigator.pushNamed(
//                                   context,
//                                   "/ProductInfo",
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                               left: AppWidthManager.w3,
//                               top: AppHeightManager.h2point2),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // اسم المنتج
//                               AppTextWidget(
//                                 text: "Product Name",
//                                 style: theme.textTheme.displayMedium?.copyWith(
//                                   color: widget.themeNotifier.value ==
//                                           ThemeMode.dark
//                                       ? AppColorManager.white
//                                       : AppColorManager.navyBlue,
//                                 ),
//                               ),
//                               // تقييم المنتج
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.yellow,
//                                     size: 16,
//                                   ),
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.yellow,
//                                     size: 16,
//                                   ),
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.yellow,
//                                     size: 16,
//                                   ),
//                                   Icon(
//                                     Icons.star,
//                                     color: Colors.yellow,
//                                     size: 16,
//                                   ),
//                                   Icon(
//                                     Icons.star_half,
//                                     color: Colors.yellow,
//                                     size: 16,
//                                   ),
//                                   SizedBox(width: 5),
//                                   Text(
//                                     "4.5",
//                                     style: TextStyle(
//                                       color: widget.themeNotifier.value ==
//                                               ThemeMode.dark
//                                           ? AppColorManager.grey
//                                           : AppColorManager.navyBlue,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               // وصف المنتج
//                               AppTextWidget(
//                                 text: "Product description",
//                                 style: theme.textTheme.bodySmall?.copyWith(
//                                   color: widget.themeNotifier.value ==
//                                           ThemeMode.dark
//                                       ? AppColorManager.grey
//                                       : AppColorManager.navyBlue,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: AppHeightManager.h1point2,
//                               ),
//                               // السعر الكلي للمنتج
//                               PriceText(
//                                 price: totalPrice,
//                                 priceStyle:
//                                     theme.textTheme.displayMedium?.copyWith(
//                                   color: widget.themeNotifier.value ==
//                                           ThemeMode.dark
//                                       ? AppColorManager.white
//                                       : AppColorManager.navyBlue,
//                                 ),
//                                 style: theme.textTheme.displayMedium?.copyWith(
//                                   color: widget.themeNotifier.value ==
//                                           ThemeMode.dark
//                                       ? AppColorManager.white
//                                       : AppColorManager.navyBlue,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                               left: AppWidthManager.w13,
//                               top: AppHeightManager.h2,
//                               bottom: AppHeightManager.h8),
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: _confirmRemoveProduct,
//                                     child: SvgPicture.asset(
//                                       AppIconManager.trash,
//                                       colorFilter: const ColorFilter.mode(
//                                         AppColorManager.yellow,
//                                         BlendMode.srcIn,
//                                       ),
//                                       width: AppWidthManager.w16,
//                                       height: AppHeightManager.h3Point5,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                   left: AppWidthManager.w60,
//                   right: AppWidthManager.w2,
//                   top: AppHeightManager.h9,
//                 ),
//                 child: DecoratedContainer(
//                   color: AppColorManager.navyBlue,
//                   width: AppWidthManager.w26,
//                   height: AppHeightManager.h4point4,
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         width: AppWidthManager.w1,
//                       ),
//                       GestureDetector(
//                         onTap: _decrementQuantity,
//                         child: DecoratedContainer(
//                           color: AppColorManager.whiteBlue,
//                           height: AppHeightManager.h3point3,
//                           width: AppWidthManager.w7,
//                           child: Center(
//                             child: SvgPicture.asset(
//                               width: AppWidthManager.w4,
//                               AppIconManager.minimize,
//                               color: AppColorManager.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: AppWidthManager.w10,
//                         child: Center(
//                             child: AppTextWidget(
//                           text: '$quantity',
//                           fontSize: FontSizeManager.fs17,
//                         )),
//                       ),
//                       GestureDetector(
//                         onTap: _incrementQuantity,
//                         child: DecoratedContainer(
//                           color: AppColorManager.navyLightBlue,
//                           height: AppHeightManager.h3point3,
//                           width: AppWidthManager.w7,
//                           child: Center(
//                             child: SvgPicture.asset(
//                               width: AppWidthManager.w4,
//                               AppIconManager.add,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: AppWidthManager.w1,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
