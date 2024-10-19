import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/storage/shared/shared_pref.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/text/price_text_widget.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/models/appModels.dart';

String getDeliveryTypeName(int deliveryType) {
  switch (deliveryType) {
    case 1:
      return 'Cycle';
    case 2:
      return 'Regular Car';
    case 3:
      return 'Passenger Car';
    case 4:
      return 'Cargo Van';
    case 5:
      return 'Truck';
    default:
      return 'Unknown';
  }
}

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key, required this.themeNotifier});
  final ValueNotifier<ThemeMode>? themeNotifier;

  @override
  // ignore: library_private_types_in_public_api
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  late Future<List<Order>> ordersFuture;
  late OrderService orderService;

  @override
  void initState() {
    super.initState();
    orderService = OrderService();
    ordersFuture = orderService.fetchOrders();
  }

  Future<void> cancelOrder(String orderId) async {
    await orderService.cancelOrder(orderId, AppSharedPreferences.getClientId());
    setState(() {
      ordersFuture = orderService.fetchOrders();
    });

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Order cancelled successfully!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = widget.themeNotifier!.value == ThemeMode.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SecondAppbar(
        titleText: "Saved Orders",
        onBack: () => Navigator.pop(context),
      ),
      body: FutureBuilder<List<Order>>(
        future: ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final statusInfo =
                    orderService.getStatusInfo(order.statusCode ?? 1);

                var appTextWidget = const AppTextWidget(
                  text: "Cancel",
                  color: AppColorManager.dotGrey,
                );
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppWidthManager.w3,
                      horizontal: AppWidthManager.w5),
                  child: Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AnimatedContainer(
                        // height: AppHeightManager.h35,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: DecoratedContainer(
                          color: widget.themeNotifier!.value == ThemeMode.dark
                              ? AppColorManager.navyLightBlue
                              : AppColorManager.whiteBlue,
                          width: AppWidthManager.w87,
                          child: Padding(
                            padding: EdgeInsets.all(AppRadiusManager.r10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: DecoratedContainer(
                                        color: widget.themeNotifier!.value ==
                                                ThemeMode.dark
                                            ? AppColorManager.navyLightBlue
                                            : AppColorManager.whiteBlue,
                                        height: AppHeightManager.h13,
                                        width: AppWidthManager.w25,
                                        child: Image.asset(
                                          AppImageManager.logo2,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: AppWidthManager.w5),
                                              child: AppTextWidget(
                                                text: "Order: ${order.id}",
                                                style: theme
                                                    .textTheme.displayLarge
                                                    ?.copyWith(
                                                  color: isDarkMode
                                                      ? AppColorManager.white
                                                      : AppColorManager
                                                          .navyBlue,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: AppWidthManager.w9,
                                            ),
                                            DecoratedContainer(
                                              height: AppHeightManager.h3Point5,
                                              width: AppWidthManager.w20,
                                              color: AppColorManager.shadow,
                                              child: Center(
                                                child: AppTextWidget(
                                                  text: statusInfo['text'],
                                                  style: theme
                                                      .textTheme.displaySmall
                                                      ?.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: statusInfo['color'],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: AppHeightManager.h1,
                                        ),
                                        Row(
                                          children: [
                                            AppTextWidget(
                                              text: 'Order ID:  ',
                                              fontSize: FontSizeManager.fs16,
                                            ),
                                            AppTextWidget(
                                                fontSize: FontSizeManager.fs16,
                                                color: AppColorManager.grey,
                                                text: order.orderNumber ??
                                                    "Not yet determined"),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            AppTextWidget(
                                              text: 'Delivery Type: ',
                                              fontSize: FontSizeManager.fs16,
                                            ),
                                            AppTextWidget(
                                                fontSize: FontSizeManager.fs16,
                                                color: const Color.fromARGB(
                                                    255, 146, 131, 78),
                                                text:
                                                    '  ${getDeliveryTypeName(order.deliveryType ?? 0)}'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            AppTextWidget(
                                                fontSize: FontSizeManager.fs16,
                                                text: 'Sub Total:  '),
                                            AppTextWidget(
                                                color: const Color.fromARGB(
                                                    255, 115, 156, 125),
                                                fontSize: FontSizeManager.fs16,
                                                text:
                                                    '${order.subTotal ?? "Not yet determined"}'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: AppHeightManager.h02,
                                ),
                                const Divider(color: AppColorManager.grey),
                                DecoratedContainer(
                                  color: const Color.fromARGB(96, 165, 22, 22),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text:
                                            "Date Order:   ${order.createdAt?.substring(0, 10)}",
                                        style: theme.textTheme.displaySmall
                                            ?.copyWith(
                                                color: AppColorManager
                                                    .shimmerHighlightColor),
                                      ),
                                      SizedBox(
                                        height: AppHeightManager.h3,
                                        width: AppWidthManager.w20,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (order.statusCode != 0) {
                                              showDialog(
                                                barrierColor:
                                                    AppColorManager.shadow,
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            216, 4, 4, 37),
                                                    title: AppTextWidget(
                                                        color:
                                                            AppColorManager.red,
                                                        fontSize:
                                                            FontSizeManager
                                                                .fs20,
                                                        text:
                                                            'Action Not Allowed'),
                                                    content: AppTextWidget(
                                                      fontSize:
                                                          FontSizeManager.fs16,
                                                      text:
                                                          'You can only cancel orders\n that are in the Pending status.',
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: AppTextWidget(
                                                          text: 'OK',
                                                          fontSize:
                                                              FontSizeManager
                                                                  .fs16,
                                                          color: AppColorManager
                                                              .white,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              return;
                                            }

                                            int points = AppSharedPreferences
                                                .getPoints();

                                            if (points < 100) {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        AppColorManager
                                                            .lightGray,
                                                    title: AppTextWidget(
                                                        color:
                                                            AppColorManager.red,
                                                        fontSize:
                                                            FontSizeManager
                                                                .fs20,
                                                        text: 'Confirmation'),
                                                    content: AppTextWidget(
                                                      text:
                                                          'Your points are less than 100.\n You cannot cancel this order.',
                                                      fontSize:
                                                          FontSizeManager.fs16,
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: AppTextWidget(
                                                          text: 'OK',
                                                          fontSize:
                                                              FontSizeManager
                                                                  .fs16,
                                                          color: AppColorManager
                                                              .white,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        AppColorManager
                                                            .lightGray,
                                                    title: AppTextWidget(
                                                      fontSize:
                                                          FontSizeManager.fs20,
                                                      text: 'Confirmation',
                                                      color: AppColorManager
                                                          .yellow,
                                                    ),
                                                    content: AppTextWidget(
                                                      text:
                                                          'Are you sure you want\n to cancel this order?',
                                                      fontSize:
                                                          FontSizeManager.fs16,
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: AppTextWidget(
                                                          text: 'NO',
                                                          fontSize:
                                                              FontSizeManager
                                                                  .fs16,
                                                          color: AppColorManager
                                                              .white,
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          await cancelOrder(
                                                              order.id
                                                                  .toString());
                                                          // ignore: use_build_context_synchronously
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: AppTextWidget(
                                                          text: 'Yes',
                                                          fontSize:
                                                              FontSizeManager
                                                                  .fs16,
                                                          color: AppColorManager
                                                              .white,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shadowColor: AppColorManager.red,
                                            backgroundColor:
                                                AppColorManager.shadow2,
                                          ),
                                          child: appTextWidget,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DecoratedContainer(
                                  color: AppColorManager.shadow,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          AppTextWidget(
                                            color: AppColorManager
                                                .shimmerHighlightColor,
                                            text:
                                                'Total:     ${order.total ?? "Not yet determined"}',
                                            fontSize: FontSizeManager.fs16,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          AppTextWidget(
                                              color: AppColorManager
                                                  .shimmerHighlightColor,
                                              fontSize: FontSizeManager.fs16,
                                              text:
                                                  'Expected time:     ${order.deliveryFee ?? "Not yet determined"}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                ExpansionTile(
                                  title: AppTextWidget(
                                    fontSize: FontSizeManager.fs17,
                                    text: "View Products",
                                  ),
                                  children: [
                                    for (var product in order.products!)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DecoratedContainer(
                                          color: AppColorManager.blackShadow,
                                          border: Border.all(
                                              color: AppColorManager.lightGrey),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: AppWidthManager.w4),
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppRadiusManager.r4),
                                                  child: DecoratedContainer(
                                                    color:
                                                        AppColorManager.shadow,
                                                    height: AppHeightManager
                                                        .h4point6,
                                                    width: AppWidthManager.w12,
                                                    child: Image.network(
                                                      fit: BoxFit.cover,
                                                      "${Config.imageUrl}/${product.image}",
                                                      // width: 50,
                                                      // height: 50,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      product.name!,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      product.desc!,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    ),
                                                    PriceText(
                                                      priceStyle: TextStyle(
                                                          color: AppColorManager
                                                              .green,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize:
                                                              FontSizeManager
                                                                  .fs15),
                                                      price: product.price,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.green),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No orders found'));
          }
        },
      ),
    );
  }
}
