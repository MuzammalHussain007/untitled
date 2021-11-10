import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/productName';
  @override
  Widget build(BuildContext context) {
    final productid = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<Product_provider>(context).findByID(productid);
    return Scaffold(
      appBar: AppBar( title :Text(loadedProduct.product_name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(loadedProduct.imageURL,fit: BoxFit.cover,),
            ),
            const SizedBox(height: 10,),
            Text('\$${loadedProduct.price}',style: const TextStyle(
              color: Colors.grey,
              fontSize: 20
            ),),
            SizedBox(
              height: 20,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(loadedProduct.product_description,style: const TextStyle(
                  fontSize: 15,
                ),
                softWrap: true,
                textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}