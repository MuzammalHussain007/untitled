import 'package:flutter/material.dart';
import 'package:untitled/modal/products.dart';

class Product_provider with ChangeNotifier {
  final List<Product> _list = [
    Product(
      id: 'p1',
      product_name: 'Red Shirt',
      product_description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageURL:
      'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      product_name: 'Trousers',
      product_description: 'A nice pair of trousers.',
      price: 59.99,
      imageURL:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      product_name: 'Yellow Scarf',
      product_description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageURL:
      'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      product_name: 'A Pan',
      product_description: 'Prepare any meal you want.',
      price: 49.99,
      imageURL:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ] ;

  List<Product> get items {
    return [..._list];
  }

  Product findByID(String id)
  {
    return _list.firstWhere((element) => element.id==id);
  }

  List<Product> get favouriteItem{
    return _list.where((element) => element.isFavourite).toList();
  }

  void addProduct()
  {
     // _list.add();
    notifyListeners();
  }




}