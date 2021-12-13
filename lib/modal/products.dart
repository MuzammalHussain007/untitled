import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled/Exception/flutter_exception.dart';
class Product with ChangeNotifier{
   final String id;
   final String product_name;
   final String product_description;
   final double price;
   final String imageURL;
   bool  isFavourite;

  Product({
    required this.id,
    required this.product_name,
    required this.product_description,
    required this.price,
    required this.imageURL,
    this.isFavourite=false
  });



  Future<void> toggleFavourite() async
  {
    final oldFavourite=isFavourite;
    isFavourite=!isFavourite;
     final  url =  Uri.parse('https://fluttterdummyproject-default-rtdb.firebaseio.com/products/$id.json');
     try{
       await http.patch(url,body:jsonEncode(
           {
             'isFavorite':isFavourite,
           }
       ));
     }catch(error)
    {
      isFavourite = oldFavourite;
      throw FlutterException('Can not add to Favourite');

    }


    notifyListeners();
  }
}