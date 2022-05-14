import 'dart:core';
import 'package:flutter/material.dart';

import './cart-provider.dart';

class Order with ChangeNotifier {
  List<OrderItem> _order = [];

  List<OrderItem> get OrderList {
    return [..._order];
  }

  void addOrder(double totalPrice, List<CartItem> CartItems) {
    _order.insert(0, OrderItem(
      id: DateTime.now().toString(),
      dateTime: DateTime.now(),
      CartItemList: CartItems,
      TotalAmount: totalPrice,
    ));
    notifyListeners();
  }

}

class OrderItem {
  final String id;
  final DateTime dateTime;
  final List<CartItem> CartItemList;
  final double TotalAmount;

  OrderItem({this.id, this.CartItemList, this.dateTime, this.TotalAmount});
}
