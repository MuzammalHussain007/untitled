import 'package:flutter/foundation.dart';
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



  void toggleFavourite()
  {
    isFavourite=!isFavourite;
    notifyListeners();
  }
}