import 'package:flutter/material.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/image_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/models/appModels.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key, required this.themeNotifier});
  final ValueNotifier<ThemeMode>? themeNotifier;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = themeNotifier == ThemeMode.dark;
    final OrderService orderService = OrderService();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SecondAppbar(
        titleText: "Save Orders",
        onBack: () => Navigator.pop(context),
      ),
      body: FutureBuilder(
        future: orderService.fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final orders = snapshot.data as List<Order>;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final statusInfo =
                    orderService.getStatusInfo(order.statusCode ?? 1);

                return Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: AppWidthManager.w3),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: DecoratedContainer(
                          color: themeNotifier!.value == ThemeMode.dark
                              ? AppColorManager.navyLightBlue
                              : AppColorManager.whiteBlue,
                          height: AppHeightManager.h20,
                          width: AppWidthManager.w87,
                          child: Padding(
                            padding: EdgeInsets.all(AppRadiusManager.r10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: DecoratedContainer(
                                        color: themeNotifier!.value ==
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
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: AppWidthManager.w3),
                                          child: SizedBox(
                                            width: AppWidthManager.w30,
                                            child: AppTextWidget(
                                              text: "Order: ${order.id}",
                                              style: theme
                                                  .textTheme.displayLarge
                                                  ?.copyWith(
                                                color: themeNotifier!.value ==
                                                        ThemeMode.dark
                                                    ? AppColorManager.white
                                                    : AppColorManager.navyBlue,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, "/Invoice");
                                          },
                                          child: AppTextWidget(
                                            text: "View Details",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                                    color: AppColorManager.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: AppHeightManager.h7),
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
                                const Divider(
                                  color: AppColorManager.grey,
                                ),
                                Row(
                                  children: [
                                    AppTextWidget(
                                      text:
                                          "Date Order: ${order.createdAt?.substring(0, 10)}",
                                      style: theme.textTheme.displaySmall
                                          ?.copyWith(
                                        color: isDarkMode
                                            ? AppColorManager.navyLightBlue
                                            : AppColorManager.white,
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
                  ],
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
