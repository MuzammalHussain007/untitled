import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/product_provider.dart';
import 'package:untitled/widget/app_drawer.dart';
import 'package:untitled/widget/edit_product_screen.dart';
import 'package:untitled/widget/product_item.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);
  static const routeName = '/edit_product';

  Future<void> refresh(BuildContext context)
  async {
          await context.read<Product_provider>().fetchAndShowProduct();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product_provider>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Your Product'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        onRefresh:()=>refresh(context) ,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemBuilder: (ctx, index) => Column(
              children: [
                UserProductItem(
                    productData.items[index].id,
                    productData.items[index].product_name,
                    productData.items[index].imageURL),
                Divider(),
              ],
            ),
            itemCount: productData.items.length,
          ),
        ),
      ),
    );
  }
}
