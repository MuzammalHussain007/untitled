import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/product_provider.dart';
import 'package:untitled/widget/app_drawer.dart';
import 'package:untitled/widget/product_item.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);
  static const routeName = '/user_product';

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product_provider>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Your Product'),
        actions: [
          IconButton(onPressed: (){

          },
              icon: const Icon(Icons.add)
          )
        ],
      ),
      body:  Padding(
        padding:  const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemBuilder: (ctx,index)=> Column(
            children: [
              UserProductItem
                (
                  productData.items[index].product_name,
                  productData.items[index].imageURL
              ),
              Divider(),
            ],
          ),
          itemCount: productData.items.length,),

      ),
    );
  }
}
