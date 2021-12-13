import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/cart_provider.dart';
import 'package:untitled/providers/order_provider.dart';
import 'package:untitled/widget/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total', style: TextStyle(fontSize: 20)),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.TotalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  ButtonAction(cart: cart),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (_, index) {
              return CartItems(
                  cart.items.values.toList()[index].id,
                  cart.items.keys.toList()[index],
                  cart.items.values.toList()[index].product_name,
                  cart.items.values.toList()[index].quantity.toInt(),
                  cart.items.values.toList()[index].price);
            },
            itemCount: cart.totalCartItem,
          ))
        ],
      ),
    );
  }
}

class ButtonAction extends StatefulWidget {
  ButtonAction({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<ButtonAction> createState() => _ButtonActionState();
}

class _ButtonActionState extends State<ButtonAction> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (widget.cart.TotalAmount <= 0 || isLoading)
          ? null
          : () async {
              setState(() {
                isLoading = true;
              });
              await Provider.of<OrderProvider>(context, listen: false).addOrder(
                  widget.cart.items.values.toList(), widget.cart.TotalAmount);
              widget.cart.clear();
              setState(() {
                isLoading = false;
              });
            },
      child: isLoading ? const CircularProgressIndicator() : Text(
        'Order Now',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
