import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:wasity/features/models/appModels.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  CartProvider() {
    _loadCartItems();
  }

  //! حساب السعر الكلي
  double get totalPrice {
    double total = 0.0;
    for (var product in _cartItems) {
      total += product.price * product.count; //? ضرب السعر في الكمية
    }
    return total;
  }

  //! إضافة منتج إلى السلة
  void addToCart(Product product) {
    _cartItems.add(product);
    _saveCartItems();
    notifyListeners();
  }

  //! إزالة منتج من السلة
  void removeFromCart(Product product) {
    _cartItems.remove(product);
    _saveCartItems();
    notifyListeners();
  }

  // !تعديل كمية منتج معين في السلة
  void updatecount(Product product, int count) {
    product.count = count;
    _saveCartItems();
    notifyListeners();
  }

  // !مسح السلة
  void clearCart() {
    _cartItems.clear();
    _saveCartItems();
    notifyListeners();
  }

  //!حفظ بيانات السلة 
  void _saveCartItems() {
   
  }

  //! تحميل بيانات السلة (اذا كان في)
  void _loadCartItems() {
  }
}
