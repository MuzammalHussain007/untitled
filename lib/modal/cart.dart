import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String product_name;
  final double quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.product_name,
      required this.quantity,
      required this.price}
      );
}


