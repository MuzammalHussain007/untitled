import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/product_provider.dart';
import 'package:untitled/widget/productitem.dart';

class Product_Builder extends StatelessWidget{
  final bool isFav;
  Product_Builder(this.isFav);

  @override
  Widget build(BuildContext context) {
    final product_excess_link = Provider.of<Product_provider>(context,listen: true);
    final product_list = isFav ? product_excess_link.favouriteItem : product_excess_link.items;
   return  GridView.builder
     (
       padding: const EdgeInsets.all(15),
       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
           childAspectRatio: 3/2 ,
           mainAxisSpacing: 10,       // spece b/w column
           crossAxisSpacing: 10),     //spece b/w rows
       itemCount:product_list.length ,
       itemBuilder: (ctx,index){
         return ChangeNotifierProvider.value(
           value: product_list[index],
             child: ProductItem(
             ));
       });
  }

}