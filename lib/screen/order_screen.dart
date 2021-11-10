import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 import 'package:untitled/providers/order_provider.dart';
import 'package:untitled/widget/app_drawer.dart';
import 'package:untitled/widget/order_item.dart' as ord;


class OrderScreen extends StatelessWidget {
  static const String routeName='/Order';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final order=Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Order'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
          itemCount: order.orders.length,
          itemBuilder: (context,index){
            return ord.OrderItem(order.orders[index]);
          }
      ),
    );
  }
}
