import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/cart_provider.dart';
import 'package:untitled/providers/order_provider.dart';
import 'package:untitled/providers/product_provider.dart';
import 'package:untitled/screen/cart_screen.dart';
import 'package:untitled/screen/order_screen.dart';
import 'package:untitled/screen/product_detail_screen.dart';
import 'package:untitled/screen/product_overview_screen.dart';
import 'package:untitled/screen/user_product_screen.dart';
import 'package:untitled/widget/edit_product_screen.dart';
import 'package:untitled/widget/update_product_screen.dart';

import 'mainstartpage.dart';

class MaterialApps extends StatelessWidget {
  const MaterialApps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
        ChangeNotifierProvider(create:(_)=> Product_provider()),
        ChangeNotifierProvider(create:(_)=> Cart()),
        ChangeNotifierProvider(create:(_)=> OrderProvider())

    ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato'
        ),
        title: 'Shop App',
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context)=>ProductDetailScreen(),
          CartScreen.routeName:(context)=>CartScreen(),
          OrderScreen.routeName:(context)=>OrderScreen(),
          UserProductScreen.routeName : (context)=>UserProductScreen(),
          EditProductScreen.routeName:  (context)=>EditProductScreen(),
          UpdateProductScreen.routeName: (context)=>UpdateProductScreen()
         },
      ),
    );
  }
}
