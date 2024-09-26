import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wasity/core/storage/shared/shared_pref.dart';
import 'package:wasity/features/models/appModels.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cartItems = []; // قائمة المنتجات في السلة
  final Map<int, int> products = {}; // تخزين كميات المنتجات في السلة

  List<Product> get cartItems => _cartItems;

  CartProvider() {
    _loadCartItems(); // تحميل بيانات السلة عند الإنشاء
  }

  //! حساب السعر الكلي
  double get totalPrice {
    double total = 0.0;
    for (var product in _cartItems) {
      final quantity = products[product.id] ?? 1;
      total += product.price * quantity;
    }
    return total;
  }

  //! إضافة منتج إلى السلة
  void addToCart(Product product) {
    if (products.containsKey(product.id)) {
      // إذا كان المنتج موجودًا بالفعل، زيادة الكمية فقط
      products[product.id] = (products[product.id] ?? 1) + 1;
    } else {
      // إذا كان المنتج غير موجود، أضفه إلى القائمة مع الكمية الابتدائية 1
      _cartItems.add(product);
      products[product.id] = 1;
    }
    _updateCartItemsApi(); // تحديث حالة API مع الكمية الجديدة
    _saveCartItems(); // حفظ حالة السلة
    notifyListeners(); // تحديث الواجهة
  }

  //! إزالة منتج من السلة
  void removeFromCart(Product product) {
    if (_cartItems.contains(product)) {
      _cartItems.remove(product); // إزالة المنتج من القائمة
      cartItemsApi
          .removeWhere((e) => e['id'] == product.id); // إزالة من الـ API
    }
    products.remove(product.id); // إزالة المنتج من خريطة الكميات
    _updateCartItemsApi(); // تحديث API
    _saveCartItems(); // حفظ حالة السلة بعد التعديل
    notifyListeners(); // تحديث الواجهة
  }

  //! تعديل كمية منتج معين في السلة
  void updateQuantity(Product product, int quantity) {
    if (_cartItems.contains(product) && quantity > 0) {
      products[product.id] = quantity;
      _updateCartItemsApi(); // تحديث API مع الكمية الجديدة
      _saveCartItems(); // حفظ حالة السلة
      notifyListeners(); // تحديث الواجهة
    } else if (quantity == 0) {
      removeFromCart(product); // حذف المنتج من السلة إذا كانت الكمية 0
    }
  }

  //! الحصول على كمية منتج معين في السلة
  int getQuantity(Product product) {
    return products[product.id] ?? 1; // الكمية الابتدائية هي 1
  }

  //! مسح السلة
  void clearCart() {
    _cartItems.clear();
    products.clear();
    cartItemsApi.clear(); // مسح الـ API أيضاً
    _saveCartItems(); // حفظ حالة السلة
    notifyListeners(); // تحديث الواجهة
  }

  //! تحديث قائمة المنتجات في الـ API
  void _updateCartItemsApi() {
    cartItemsApi.clear(); //! مسح القائمة القديمة

    //! تحديث الـ API بالبيانات الصحيحة
    products.forEach((id, count) {
      if (count > 0) {
        cartItemsApi.add({
          'id': id,
          'count': count, //! تأكد من أن الكمية يتم تحديثها بشكل صحيح
        });
      }
    });
  }

  //! حفظ بيانات السلة (تخزين محلي)
  void _saveCartItems() {
    List<Map<String, dynamic>> cartItemsJson = _cartItems.map((product) {
      return {
        'product': product.toJson(), //! تحويل المنتج إلى JSON
        'quantity': products[product.id], //! تخزين الكمية
      };
    }).toList();

    String cartItemsString =
        jsonEncode(cartItemsJson); // تحويل القائمة إلى JSON
    AppSharedPreferences.cacheCartItems(
        cartItemsString); // تخزين السلسلة في SharedPreferences
  }

  //! تحميل بيانات السلة (إذا كانت موجودة)
  void _loadCartItems() {
    String cartItemsString = AppSharedPreferences.getCartItems();
    if (cartItemsString.isNotEmpty) {
      List<dynamic> cartItemsJson = jsonDecode(cartItemsString);

      for (var item in cartItemsJson) {
        Product product = Product.fromJson(item['product']);
        int quantity = item['quantity'];

        // !التأكد من أن المنتج لا يتم إضافته أكثر من مرة
        if (!products.containsKey(product.id)) {
          _cartItems.add(product);
        }
        products[product.id] = quantity;
      }

      _updateCartItemsApi(); //! تحديث الـ API بعد تحميل السلة

      notifyListeners(); //! تحديث الواجهة
    }
  }
}//! متغير لتخزين البيانات التي يتم إرسالها إلى API
List<Map> cartItemsApi = [];