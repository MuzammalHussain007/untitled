import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/cart_provider.dart';

class CartItems extends StatelessWidget {

  final String id;
  final String productid;
  final String titles;
  final int quantity;
  final double price;


  CartItems(this.id,this.productid, this.titles, this.quantity, this.price);

  @override
  Widget build(BuildContext context) {
    return  Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 15
        ),

      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
          return await showDialog(context: context, builder: (ctx)=> AlertDialog(
               title: const Text('Are You Want to Sure'),
               content: const Text('Do You Want to Remove Item From Cart'),
               actions: [
                 FlatButton(onPressed: (){
                  Navigator.of(ctx).pop(false);
                 }, child:const Text('No')),
                 FlatButton(onPressed: (){
                   print('wirkunf');
                   Navigator.of(ctx).pop(true);
                 }, child:const Text('Yes'))
               ],
             ));
      },
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).remvoeItem(productid);
      },
      child: Card(

        child: Padding(
            padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding:const EdgeInsets.all(5),
                child: FittedBox(
                    child: Text('\$$price')),
              ),
            ),
            title: Text(titles),
            subtitle: Text('Total:\$${(price*quantity)}'),
            trailing: Text('$quantity x'),

          ),
        ),
      ),
    );
  }
}
