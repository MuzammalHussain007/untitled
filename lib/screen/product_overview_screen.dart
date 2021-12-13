import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/modal/products.dart';
import 'package:untitled/providers/cart_provider.dart';
import 'package:untitled/providers/product_provider.dart';
import 'package:untitled/widget/app_drawer.dart';
import 'package:untitled/widget/badge.dart';
import 'package:untitled/widget/product_grid.dart';
import 'cart_screen.dart';


enum FilterOption{
  Favourites,
  SelectAll
}
var init = false;

class ProductsOverviewScreen extends StatefulWidget {


    ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var showFavouriteOnly=false;
  var _initShow=true;
  final List<Product> product_list = [
  ];
       @override
  void didChangeDependencies() {
    if(_initShow)
      {
        context.read<Product_provider>().fetchAndShowProduct();
      }
    _initShow=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOption selid){
              setState(() {
                if(selid==FilterOption.Favourites)
                {
                  showFavouriteOnly=true;
                }
                else
                {
                  showFavouriteOnly=false;
                }
              });


            },
            icon: const Icon(Icons.more_vert),
              itemBuilder: (_)=> [
                const PopupMenuItem(child: Text('Only Favourites'),value: FilterOption.Favourites,),
                const PopupMenuItem(child: Text('Show All'),value: FilterOption.SelectAll,)
              ]
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              value: cart.totalCartItem.toString(),
              child:ch as Widget ,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body:Product_Builder(showFavouriteOnly),
    );
  }
}


