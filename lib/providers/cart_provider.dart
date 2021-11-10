import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:untitled/modal/cart.dart';

class Cart with ChangeNotifier {
  Map<String , CartItem> _cartItem = {};

 Map<String,CartItem> get items{
   return {..._cartItem};
}

void addProduct(String producdid,String prodname,double price)
{
  if(_cartItem.containsKey(producdid))
    {
      _cartItem.update(producdid, (value) => CartItem(id: value.id,
          product_name:value.product_name,
          quantity: value.quantity+1,
          price: value.price
      ));

    }else
      {
        _cartItem.putIfAbsent(producdid, () => CartItem(
            id: DateTime.now().toString(),
            product_name:prodname ,
            quantity: 1,
            price: price));
      }
  notifyListeners();
}
 int get totalCartItem{
   print('this works');
   return  _cartItem.length;
}

  double get TotalAmount{
   var total =0.0;
   _cartItem.forEach((key, CartItem) {
     total+=CartItem.price*CartItem.quantity;
   });
   return total;
  }

  void remvoeItem(String id)
  {
    _cartItem.remove(id);
    notifyListeners();
  }
  void clear() {
    _cartItem = {};
    notifyListeners();
  }

  void removeSingleItem(String id)
  {
    if(!_cartItem.containsKey(id))
      {
        return;
      }
    if(_cartItem[id]!.quantity > 1)
      {
       _cartItem.update(id, (value) =>CartItem(id: value.id,
           product_name: value.product_name,
           quantity: value.quantity-1,
           price: value.price)
       );
      }
    else
      {
        _cartItem.remove(id);
      }
    notifyListeners();
  }
}