import 'package:flutter/material.dart';
import 'package:untitled/modal/cart.dart';
import 'package:untitled/modal/orderitem.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderProvider extends ChangeNotifier {
  final URL = Uri.parse(
      'https://fluttterdummyproject-default-rtdb.firebaseio.com/orders.json');
   List<OrderItem> _orderItem = [];

  List<OrderItem> get orders {
    return [..._orderItem];
  }

  Future<void> fetchAndSetOrders() async {
    final response = await http.get(URL);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          product: (orderData['orderedProduct'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  product_name: item['product_name'],
                ),
              )
              .toList(),
        ),
      );
    });
    _orderItem = loadedOrders;
     notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartItem, double total) async {
    final timestamp = DateTime.now();
    final cartItems = cartItem
        .map((e) => {
              'id': e.id,
              'product_name': e.product_name,
              'quantity': e.quantity,
              'price': e.price
            })
        .toList();
    final response = await http.post(URL,
        body: jsonEncode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'orderedProduct': cartItems,
        }));

    _orderItem.insert(
        0,
        OrderItem(
            product: cartItem,
            amount: total,
            dateTime: DateTime.now(),
            id: json.decode(response.body)['name']));
    notifyListeners();
  }
}
