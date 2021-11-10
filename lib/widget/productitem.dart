import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/modal/products.dart';
import 'package:untitled/providers/cart_provider.dart';
import 'package:untitled/screen/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id,title , imageUrl;
  //
  //
  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
  final product=Provider.of<Product>(context,listen: false);
  final cart=Provider.of<Cart>(context,listen: false);
    return GridTile(
        child:GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,arguments: product.id);
          },
            child: Image.network(product.imageURL,fit:BoxFit.cover,)),
      footer: GridTileBar(
        trailing:IconButton(icon:  Icon(
            Icons.shopping_cart,
            color: Theme.of(context).accentColor,
        ),
          onPressed: () {
          cart.addProduct(product.id, product.product_name, product.price);
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(
             SnackBar(
              content: const Text('Item Added into Cart'),
              duration: const Duration(
                seconds: 2
              ),
              action: SnackBarAction(
                label: 'UNDO',
                onPressed: () { cart.removeSingleItem(product.id);},
              ),


            )
          );
          },
        ) ,
        leading: Consumer<Product>(
          builder: (ctx,product,child)=>IconButton(icon:  Icon(
            product.isFavourite ? Icons.favorite : Icons.favorite_border,
            color: Theme.of(context).accentColor,
          ),
            onPressed: ()=>product.toggleFavourite(),
          ) ,
        ),
        backgroundColor: Colors.black87,
        title: Text(product.product_name,textAlign: TextAlign.center,),
      ),
    );
  }
}
