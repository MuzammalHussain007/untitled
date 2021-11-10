import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/cart_provider.dart';
import 'package:untitled/providers/order_provider.dart';
import 'package:untitled/widget/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName='/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children:   [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(padding: const EdgeInsets.all(10),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:   [
                  const Text('Total',
                      style:TextStyle(
                        fontSize: 20
                  )),
                  const Spacer(),
                  Chip(label: Text('\$${cart.TotalAmount.toStringAsFixed(2)}',style: const TextStyle(
                      color: Colors.white
                  ),),
                  backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(onPressed: (){
                    Provider.of<OrderProvider>(context,listen: false).addOrder(
                        cart.items.values.toList(),
                        cart.TotalAmount);
                    cart.clear();
                  },
                    child: Text('Order Now',style: TextStyle(
                      color: Theme.of(context).primaryColor
                    ),),
                  ),

                ],
              ) ,

            ),

          ),
          const SizedBox( height: 10,),
          Expanded(
              child:ListView.builder(
                  itemBuilder: (_,index){
                    return CartItems(
                        cart.items.values.toList()[index].id,
                        cart.items.keys.toList()[index],
                        cart.items.values.toList()[index].product_name,
                        cart.items.values.toList()[index].quantity.toInt(),
                        cart.items.values.toList()[index].price
                    );
                  },
                itemCount:cart.totalCartItem ,
              )
          )
        ],

      ),
    );
  }
}

