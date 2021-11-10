import 'package:flutter/material.dart';
import 'package:untitled/modal/cart.dart';
import 'package:untitled/modal/orderitem.dart';

class OrderProvider extends ChangeNotifier
{
  final List<OrderItem> _orderItem = [];

  List<OrderItem> get orders{
    return [..._orderItem];
  }

  void addOrder(List<CartItem> cartItem , double total  )
  {
    _orderItem.insert(0, OrderItem(product: cartItem,
        amount: total,
        dateTime: DateTime.now(),
        id: DateTime.now().toString()
    ));
    notifyListeners();
  }
}