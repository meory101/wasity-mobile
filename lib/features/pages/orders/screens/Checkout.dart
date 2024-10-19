import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/resource/font_manager.dart';
import 'package:wasity/core/resource/icon_manager.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/core/storage/shared/shared_pref.dart';
// ignore: depend_on_referenced_packages
import 'package:wasity/core/widget/app_bar/second_appbar.dart';
import 'package:wasity/core/widget/button/app_button.dart';
import 'package:wasity/core/widget/container/decorated_container.dart';
import 'package:wasity/core/widget/text/app_text_widget.dart';
import 'package:wasity/core/widget/text/price_text_widget.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/pages/auth/screens/finger_print.dart';
import 'package:wasity/features/pages/cart/provider/cart_provider.dart';
import 'package:wasity/features/pages/cart/widgets/cartItemsList/cart_list.dart';
// ignore: depend_on_referenced_packages
import 'package:lottie/lottie.dart';
import 'package:wasity/features/pages/home/widgets/button/delivery_type_slidder.dart';
import 'package:wasity/features/pages/profile/container/pay%20_containers.dart';

class Checkout extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const Checkout({super.key, required this.themeNotifier});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  // ignore: non_constant_identifier_names
  int? delivery_type;
  // ignore: non_constant_identifier_names
  int? address_id;
  // ignore: non_constant_identifier_names
  int? client_id;
  // ignore: non_constant_identifier_names
  int? pay_type;

  @override
  void initState() {
    super.initState();

    String? addressIdString = AppSharedPreferences.getSelectedAddressId();
    String? clientIdString = AppSharedPreferences.getClientId();
    client_id = clientIdString != null ? int.tryParse(clientIdString) : null;
    address_id = addressIdString != null ? int.tryParse(addressIdString) : null;
    delivery_type = AppSharedPreferences.getDeliveryType();
  }

  Future<void> placeOrder() async {
    try {
      if (pay_type == null ||
          address_id == null ||
          client_id == null ||
          delivery_type == null) {
        if (kDebugMode) {
          print(
              "Missing required fields: pay_type, address_id, client_id, or delivery_type");
        }
        return;
      }
      final placeOrderService = PlaceOrderService();
      await placeOrderService.placeOrder(
        payType: pay_type!,
        addressId: address_id!,
        clientId: client_id!,
        deliveryType: delivery_type!,
        cartItems: cartItemsApi,
      );
      // ignore: use_build_context_synchronously
      showOrderResultDialog(context, true);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred while placing order: $e');
      }
      // ignore: use_build_context_synchronously
      showOrderResultDialog(context, false);
    }
  }

  void showOrderResultDialog(BuildContext context, bool isSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(192, 130, 130, 130),
          content: SizedBox(
            height: AppHeightManager.h30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isSuccess
                    ? Column(
                        children: [
                          Lottie.asset(
                            height: AppHeightManager.h13,
                            AppIconManager.success,
                          ),
                          SizedBox(height: AppHeightManager.h2),
                          Semantics(
                            label: 'تمت عملية الطلب بنجاح',
                            child: const Text(
                              'Order placed successfully!',
                              style: TextStyle(
                                  color: AppColorManager.white, fontSize: 20),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: AppHeightManager.h15,
                            child: Lottie.asset(
                              height: AppHeightManager.h13,
                              AppIconManager.error,
                            ),
                          ),
                          SizedBox(height: AppHeightManager.h2),
                          Semantics(
                            label: 'فشلت عملية التحقق ',
                            child: const Text(
                              'Failed to place the order.\nPlease try again.',
                              style: TextStyle(
                                  color: AppColorManager.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
          actions: isSuccess
              ? [
                  Semantics(
                    label: 'صفحة تتبع حالةالطلب',
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/OrderHistory');
                      },
                      child: const Text(
                        'View Order',
                        style: TextStyle(
                            color: AppColorManager.yellow, fontSize: 15),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/ButtonNavbar');
                    },
                    child: Semantics(
                      label: 'الاستمرار بالتسوق',
                      child: const Text(
                        'Continue Shopping',
                        style: TextStyle(
                            color: AppColorManager.yellow, fontSize: 15),
                      ),
                    ),
                  ),
                ]
              : [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                          color: AppColorManager.yellow, fontSize: 15),
                    ),
                  ),
                ],
        );
      },
    );
  }

  void _onPaymentMethodSelected(int selectedPayType) {
    setState(() {
      pay_type = selectedPayType;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: SecondAppbar(
        titleText: "Checkout",
        onBack: () => Navigator.pop(context),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppWidthManager.w5Point3,
            vertical: AppHeightManager.h2,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Semantics(
                    label: 'العناوين المحفوظة',
                    child: AppTextWidget(
                      text: "Shipping Address",
                      style: theme.textTheme.displayLarge?.copyWith(
                        color: theme.brightness == Brightness.dark
                            ? AppColorManager.white
                            : AppColorManager.navyBlue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppHeightManager.h2),
              FutureBuilder<String?>(
                future: Future.delayed(Duration.zero, () {
                  return AppSharedPreferences.getSelectedLocation();
                }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return AppTextWidget(
                      text: "Loading...",
                      style: theme.textTheme.displayMedium?.copyWith(
                        color: theme.brightness == Brightness.dark
                            ? AppColorManager.white
                            : AppColorManager.navyBlue,
                      ),
                    );
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return DecoratedContainer(
                      height: AppHeightManager.h10,
                      borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                      color: theme.brightness == Brightness.dark
                          ? AppColorManager.navyBlue
                          : AppColorManager.whiteBlue,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: AppRadiusManager.r6,
                          color: AppColorManager.grey,
                        ),
                      ],
                      child: Padding(
                        padding: EdgeInsets.only(left: AppWidthManager.w8),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(27),
                              child: Container(
                                height: AppHeightManager.h6,
                                width: AppWidthManager.w13point5,
                                color: theme.brightness == Brightness.dark
                                    ? AppColorManager.navyLightBlue
                                    : AppColorManager.lightGrey,
                                child: Icon(
                                  Icons.location_on_rounded,
                                  size: AppHeightManager.h3,
                                  color: theme.brightness == Brightness.dark
                                      ? AppColorManager.white
                                      : AppColorManager.navyLightBlue,
                                ),
                              ),
                            ),
                            SizedBox(width: AppWidthManager.w8),
                            AppTextWidget(
                              text: snapshot.data!,
                              style: theme.textTheme.displayMedium?.copyWith(
                                color: theme.brightness == Brightness.dark
                                    ? AppColorManager.white
                                    : AppColorManager.navyBlue,
                              ),
                            ),
                            const Spacer(),
                            Semantics(
                              label:
                                  'اضغط للانتقال الى العناوين المحفوظة او اضافة عنوان جديد ',
                              child: IconButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, '/SavedAddresses'),
                                icon:
                                    const Icon(Icons.arrow_forward_ios_rounded),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, '/SavedAddresses'),
                      child: Semantics(
                        label: 'موفع التوصيل غير محدد اضغط للتحديد',
                        child: AppTextWidget(
                          text: "Location not set",
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: theme.brightness == Brightness.dark
                                ? AppColorManager.red
                                : AppColorManager.red,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: AppHeightManager.h2),
              const Divider(color: AppColorManager.shadow2),
              SizedBox(height: AppHeightManager.h2),
              Row(
                children: [
                  Semantics(
                    label: 'نوع التوصيل',
                    child: AppTextWidget(
                      text: "Choose Shipping",
                      style: theme.textTheme.displayLarge?.copyWith(
                        color: theme.brightness == Brightness.dark
                            ? AppColorManager.white
                            : AppColorManager.navyBlue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: AppWidthManager.w100,
                height: AppHeightManager.h12,
                child: DeliveryTypeSlider(
                  currentValue: delivery_type,
                  onValueChanged: (value) {
                    setState(() {
                      delivery_type = value;
                      AppSharedPreferences.cacheDeliveryType(value!);
                    });
                  },
                  iconSize: 40,
                  textSize: 20,
                ),
              ),
              if (delivery_type == 1)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  //!!!هذا الخيار قد يفرض رسوم توصيل اضافية'
                  child: AppTextWidget(
                    text: "This option may incur additional delivery charges.",
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              const Divider(color: AppColorManager.shadow2),
              SizedBox(height: AppHeightManager.h2),
              CartItemsWidget(
                themeNotifier: widget.themeNotifier,
                onRemove: (product) {
                  final cartProvider =
                      Provider.of<CartProvider>(context, listen: false);
                  cartProvider.removeFromCart(product);
                },
              ),
              const Divider(color: AppColorManager.shadow2),
              SizedBox(height: AppHeightManager.h2),
              Row(
                children: [
                  AppTextWidget(
                    text: "Payment Method",
                    style: theme.textTheme.displayLarge?.copyWith(
                      color: theme.brightness == Brightness.dark
                          ? AppColorManager.white
                          : AppColorManager.navyBlue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppHeightManager.h4),
              SelectableContainers(
                onPaymentMethodSelected: _onPaymentMethodSelected,
              ),
              SizedBox(height: AppHeightManager.h2),
              const Divider(color: AppColorManager.shadow2),
              SizedBox(height: AppHeightManager.h4),
              DecoratedContainer(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppRadiusManager.r10),
                    topRight: Radius.circular(AppRadiusManager.r10)),
                height: AppHeightManager.h10,
                width: AppWidthManager.w80,
                color: AppColorManager.white,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: AppWidthManager.w4),
                      child: AppTextWidget(
                        text: "Sub Total: ",
                        style: theme.textTheme.bodyLarge,
                        color: AppColorManager.black,
                      ),
                    ),
                    Consumer<CartProvider>(
                      builder: (context, cartProvider, child) {
                        return Padding(
                          padding:
                              EdgeInsets.only(bottom: AppHeightManager.h03),
                          child: PriceText(
                            price: cartProvider.totalPrice,
                            priceStyle: theme.textTheme.bodyLarge,
                            style: theme.textTheme.headlineSmall,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppHeightManager.h7,
                child: AppElevatedButton(
                  textColor: AppColorManager.black,
                  text: "Place Order",
                  color: AppColorManager.lightGrey,
                  onPressed: () async {
                    // print('address_id: $address_id');
                    // print('delivery_type: $delivery_type');
                    // print('client_id: $client_id');
                    // print('pay_type: $pay_type');
                    // print('products: $cartItemsApi');

                    //! للتأخير وقت البصمة
                    final bool? isAuthenticated =
                        await showFingerprintAuthDialog(context);

                    if (isAuthenticated == true) {
                      if (kDebugMode) {
                        print('Authentication successful. Placing order...');
                      }
                      await placeOrder();
                    } else {
                      if (kDebugMode) {
                        print('Authentication failed. Order not placed.');
                      }
                      // ignore: use_build_context_synchronously
                      showOrderResultDialog(context, false);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> showFingerprintAuthDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(192, 130, 130, 130),
          title: AppTextWidget(
              fontSize: FontSizeManager.fs18,
              color: AppColorManager.yellow,
              text: 'Authentication Required'),
          content: SizedBox(
            height: AppHeightManager.h25,
            child: Column(children: [
              const Divider(
                color: AppColorManager.grey,
              ),
              const Row(
                children: [
                  AppTextWidget(
                    text: 'Confirm the order....',
                    fontSize: 18,
                  ),
                ],
              ),
              Row(
                children: [
                  Semantics(
                    label: 'السعر الكلي للطلب',
                    child: const AppTextWidget(
                      text: 'the total price:   ',
                      fontSize: 18,
                    ),
                  ),
                  Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: AppHeightManager.h03),
                        child: Semantics(
                          label: 'السعر الكلي للطلب',
                          child: PriceText(
                            price: cartProvider.totalPrice,
                            priceStyle: const TextStyle(
                                fontSize: 18, color: AppColorManager.green),
                            style: const TextStyle(
                                fontSize: 15, color: AppColorManager.green),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const Divider(
                color: AppColorManager.grey,
              ),
              SizedBox(
                height: AppHeightManager.h2,
              ),
              const Row(
                children: [
                  AppTextWidget(
                      fontSize: 18,
                      color: AppColorManager.dotGrey,
                      text: 'Please authenticate \nusing your fingerprint.'),
                ],
              ),
            ]),
          ),
          actions: [
            Semantics(
              label: 'تراجع عن الشراء',
              child: IconButton(
                icon: const Icon(Icons.cancel, color: Colors.red),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ),
            IconButton(
              onPressed: () async {
                final isAuthenticated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FingerprintAuthPage()),
                );
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop(isAuthenticated);
              },
              icon: Semantics(
                  label: 'تأكيد الشراء بالبصمة',
                  child: const Icon(Icons.fingerprint, color: Colors.green)),
            ),
          ],
        );
      },
    );
  }
}
