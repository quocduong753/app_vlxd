import 'package:app_vlxd/model/VatTuDetail.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<VatTuDetail> _cartItems = [];

  List<VatTuDetail> get cartItems => _cartItems;

  int get getTotal => _cartItems.length ;

  void addToCart(VatTuDetail item) {
    int index = _cartItems.indexWhere((cartItem) => cartItem.vatTu.ma == item.vatTu.ma);
    if (index != -1) {
      _cartItems[index].soLuong += item.soLuong;
      _cartItems[index].gia = (_cartItems[index].vatTu.donGia * _cartItems[index].soLuong).toInt();
    } else {
      _cartItems.add(item);
    }
    notifyListeners();
  }

  void removeItems(List<VatTuDetail> items){
    for(dynamic item in items){
      _cartItems.remove(item);
      notifyListeners();
    }
  }

  void removeFromCart(String maVatTu) {
    _cartItems.removeWhere((item) => item.vatTu.ma == maVatTu);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double calculateTotalPrice() {
    return _cartItems.fold(0, (total, item) => total + item.gia);
  }
}