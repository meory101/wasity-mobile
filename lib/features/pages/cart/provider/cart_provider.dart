import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wasity/core/storage/shared/shared_pref.dart';
import 'package:wasity/features/models/appModels.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cartItems = [];
  final Map<int, int> products = {}; //! الماب لتخزين كميات المنتجات في السلة

  List<Product> get cartItems => _cartItems;

  CartProvider() {
    _loadCartItems(); //! تحميل بيانات السلة عند الإنشاء
  }

  //! حساب السعر الكلي
  double get totalPrice {
    print(products);
    double total = 0.0;
    for (var product in _cartItems) {
      final quantity = products[product.id] ?? 1;
      total += product.price * quantity;
    }
    return total;
  }

  //! إضافة منتج إلى السلة
  void addToCart(Product product) {
    if (!_cartItems.contains(product)) {
      _cartItems.add(product);
      products[product.id] = 1; //! تعيين الكمية الابتدائية إلى 1
    } else {
      products[product.id] = (products[product.id] ?? 1) + 1;
    }
    _saveCartItems();
    notifyListeners();
  }

  //! إزالة منتج من السلة
  void removeFromCart(Product product) {
    if (_cartItems.contains(product)) {
      _cartItems.remove(product);

      cartItemsApi.removeWhere((e) => e['id'] == product.id);
    }

    print(cartItemsApi.length);
    print("after deleting");
    products.remove(product.id);
    _saveCartItems(); //! حفظ حالة السلة بعد التعديل
    notifyListeners(); // !تحديث الواجهة
  }

  //! تعديل كمية منتج معين في السلة
  void updateQuantity(Product product, int quantity) {
    if (_cartItems.contains(product) && quantity > 0) {
      products[product.id] = quantity;
      _saveCartItems();
      notifyListeners();
    } else if (quantity == 0) {
      removeFromCart(product); //! حذف المنتج من السلة إذا كانت الكمية 0
    }
  }

  //! الحصول على كمية منتج معين في السلة
  int getQuantity(Product product) {
    return products[product.id] ?? 1;
  }

  // !مسح السلة
  void clearCart() {
    _cartItems.clear();
    products.clear();
    cartItemsApi.clear();
    _saveCartItems();
    notifyListeners();
  }

  // !حفظ بيانات السلة (تخزين محلي)
  void _saveCartItems() {
    List<Map<String, dynamic>> cartItemsJson = _cartItems.map((product) {
      return {
        'product': product.toJson(), //! تحويل المنتج إلى JSON
        'quantity': products[product.id], //! تخزين الكمية
      };
    }).toList();

    String cartItemsString =
        jsonEncode(cartItemsJson); //! تحويل القائمة إلى JSON
    AppSharedPreferences.cacheCartItems(cartItemsString);

    _loadCartItems(); //! تخزين السلسلة في SharedPreferences
  }

  //! تحميل بيانات السلة (إذا كانت موجودة)
  void _loadCartItems() {
    String cartItemsString = AppSharedPreferences.getCartItems();
    if (cartItemsString.isNotEmpty) {
      List<dynamic> cartItemsJson = jsonDecode(cartItemsString);

      for (var item in cartItemsJson) {
        print('-----------------------');
        print(cartItemsString);
        print('-----------------------');

        Product product = Product.fromJson(item['product']);
        if (cartItemsApi.isEmpty) {
          print('99999');
          cartItemsApi.add({"id": product.id, "count": item['quantity']});
        }
        for (int i = 0; i < cartItemsApi.length; i++) {
          print('0000');
          if (cartItemsApi[i]['id'] == product.id) {
            cartItemsApi[i]['count'] = item['quantity'];
          } else {
            cartItemsApi.add({"id": product.id, "count": item['quantity']});
          }
        }
        // int quantity = item['quantity']  ;
        // _cartItems.add(product);
        // products[product.id] = quantity;
      }

      print('api  api');
      print(cartItemsApi);
      print(cartItemsApi.length);
      print('api  api');
    }
    notifyListeners();
  }
}

List<Map> cartItemsApi = [];
