import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled/modal/orderitem.dart' as ord;
import 'package:intl/intl.dart';
class OrderItem extends StatefulWidget {
  final ord.OrderItem orderItem;

  OrderItem(this.orderItem);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var isExpanded=false;
  @override
  Widget build(BuildContext context) {
    return   Card(
      margin: const EdgeInsets.all(10.0),
      child: Column (
        children: [
          ListTile(
            title: Text('\$${widget.orderItem.amount}'),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.orderItem.dateTime)),
            trailing: IconButton(onPressed: () {
              setState(() {
                isExpanded=!isExpanded;
              });
            },
              icon:   Icon( isExpanded ? Icons.expand_less :Icons.expand_more),
            ),
          ),
          isExpanded ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 4),
            height: min(widget.orderItem.product.length*5.0+60, 180),
            child: ListView.builder(
                 itemCount: widget.orderItem.product.length,
                itemBuilder: (ctx,i)=>Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.orderItem.product[i].product_name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),),
                    Text('${widget.orderItem.product[i].quantity} x \$${widget.orderItem.product[i].price}',
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold
                      ),)
                  ],
                )
            ),
          ) : Container(),
        ],
      )


    );
  }
}
