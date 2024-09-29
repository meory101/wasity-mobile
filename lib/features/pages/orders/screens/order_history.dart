import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/storage/shared/shared_pref.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/models/appModels.dart';
import 'package:wasity/features/pages/orders/screens/invoice_page.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key, required this.themeNotifier});
  final ValueNotifier<ThemeMode>? themeNotifier;

  @override
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
      // Update the ordersFuture to refresh the list
      ordersFuture = orderService.fetchOrders();
    });

    // Show a SnackBar
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

                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppWidthManager.w3,
                      horizontal: AppWidthManager.w5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: DecoratedContainer(
                      color: widget.themeNotifier!.value == ThemeMode.dark
                          ? AppColorManager.navyLightBlue
                          : AppColorManager.whiteBlue,
                      height: AppHeightManager.h20,
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
                                    height: AppHeightManager.h12,
                                    width: AppWidthManager.w25,
                                    child: InkWell(
                                      child: Image.asset(
                                        AppImageManager.logo2,
                                        fit: BoxFit.cover,
                                      ),
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          "/Invoice",
                                          arguments: order,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: AppWidthManager.w2),
                                      child: AppTextWidget(
                                        text: "Order: ${order.id}",
                                        style: theme.textTheme.displayLarge
                                            ?.copyWith(
                                          color: isDarkMode
                                              ? AppColorManager.white
                                              : AppColorManager.navyBlue,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Invoice(
                                                  themeNotifier:
                                                      widget.themeNotifier,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: AppWidthManager.w9),
                                            child: AppTextWidget(
                                              text: "View Details",
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              173,
                                                              90,
                                                              90)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: AppHeightManager.h8,
                                      left: AppWidthManager.w10),
                                  child: DecoratedContainer(
                                    height: AppHeightManager.h3Point5,
                                    width: AppWidthManager.w20,
                                    color: AppColorManager.shadow,
                                    child: Center(
                                      child: AppTextWidget(
                                        text: statusInfo['text'],
                                        style: theme.textTheme.displaySmall
                                            ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: statusInfo['color'],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(color: AppColorManager.grey),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppTextWidget(
                                  text:
                                      "Date Order: ${order.createdAt?.substring(0, 10)}",
                                  style: theme.textTheme.displaySmall
                                      ?.copyWith(color: AppColorManager.white),
                                ),
                                SizedBox(
                                  height: AppHeightManager.h3,
                                  width: AppWidthManager.w20,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (order.statusCode != 0) {
                                        showDialog(
                                          barrierColor: AppColorManager.shadow,
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor:
                                                  AppColorManager.lightGray,
                                              title: AppTextWidget(
                                                  color: AppColorManager.red,
                                                  fontSize:
                                                      FontSizeManager.fs20,
                                                  text: 'Action Not Allowed'),
                                              content: AppTextWidget(
                                                fontSize: FontSizeManager.fs16,
                                                text:
                                                    'You can only cancel orders\n that are in the Pending status.',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: AppTextWidget(
                                                    text: 'OK',
                                                    fontSize:
                                                        FontSizeManager.fs16,
                                                    color:
                                                        AppColorManager.white,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        return;
                                      }

                                      int points =
                                          AppSharedPreferences.getPoints();

                                      if (points < 100) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor:
                                                  AppColorManager.lightGray,
                                              title: AppTextWidget(
                                                  color: AppColorManager.red,
                                                  fontSize:
                                                      FontSizeManager.fs20,
                                                  text: 'Confirmation'),
                                              content: AppTextWidget(
                                                text:
                                                    'Your points are less than 100.\n You cannot cancel this order.',
                                                fontSize: FontSizeManager.fs16,
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: AppTextWidget(
                                                    text: 'OK',
                                                    fontSize:
                                                        FontSizeManager.fs16,
                                                    color:
                                                        AppColorManager.white,
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
                                                  AppColorManager.lightGray,
                                              title: AppTextWidget(
                                                fontSize: FontSizeManager.fs20,
                                                text: 'Confirmation',
                                                color: AppColorManager.yellow,
                                              ),
                                              content: AppTextWidget(
                                                text:
                                                    'Are you sure you want\n to cancel this order?',
                                                fontSize: FontSizeManager.fs16,
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: AppTextWidget(
                                                    text: 'NO',
                                                    fontSize:
                                                        FontSizeManager.fs16,
                                                    color:
                                                        AppColorManager.white,
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    // Cancel the order
                                                    await cancelOrder(
                                                        order.id.toString());
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: AppTextWidget(
                                                    text: 'Yes',
                                                    fontSize:
                                                        FontSizeManager.fs16,
                                                    color:
                                                        AppColorManager.white,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColorManager.shadow2,
                                    ),
                                    child: AppTextWidget(
                                      text: "Cancel",
                                      color: AppColorManager.lightGrey,
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
