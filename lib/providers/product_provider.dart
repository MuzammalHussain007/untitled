import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:untitled/Exception/flutter_exception.dart';
import 'package:untitled/modal/products.dart';
import 'package:http/http.dart' as http;

class Product_provider with ChangeNotifier {
  final  String  URL = 'https://fluttterdummyproject-default-rtdb.firebaseio.com/products.json';
   List<Product> _list = [
    // Product(
    //   id: 'p1',
    //   product_name: 'Red Shirt',
    //   product_description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageURL:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   product_name: 'Trousers',
    //   product_description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageURL:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   product_name: 'Yellow Scarf',
    //   product_description:
    //       'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageURL:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   product_name: 'A Pan',
    //   product_description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageURL:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._list];
  }

  Product findByID(String id) {
    return _list.firstWhere((element) => element.id == id);
  }

  List<Product> get favouriteItem {
    return _list.where((element) => element.isFavourite).toList();
  }

  void  addProduct(Product product) async {
    var encodedbody=json.encode({
      'title': product.product_name,
      'description': product.product_description,
      'imageUrl': product.imageURL,
      'price': product.price,
      'isFavorite': product.isFavourite,
    });
    await http.post(Uri.parse(URL), body: encodedbody,).then((value) {
      print(json.decode(value.body));
      final newProduct = Product(
        product_name: product.product_name,
        product_description: product.product_description,
        price: product.price,
        imageURL: product.imageURL ,
        id: json.decode(value.body)['name'],
      );
      _list.add(newProduct);
    });

    print('Product Added');
    notifyListeners();
  }

  void updateProduct(String id,Product newProduct) async
  {
    final url = 'https://fluttterdummyproject-default-rtdb.firebaseio.com/products/$id.json';
    await http.patch(Uri.parse(url),
        body:json.encode(
          {
           'title' : newProduct.product_name,
           'price' : newProduct.price,
           'description' : newProduct.product_description,
           'imageUrl' : newProduct.imageURL,
            'isFavorite' : newProduct.isFavourite
          }
        )
    );
    final index=_list.indexWhere((element) => element.id==id);
    if (index > 0) {
      _list[index]=newProduct;
    }
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async
  {
    print('id is '+id);

    final url = Uri.parse('https://fluttterdummyproject-default-rtdb.firebaseio.com/products/$id.json');
    print(url);
    final deletedProductIndex = _list.indexWhere((element) => element.id==id);
    Product?  deletedProductData = _list[deletedProductIndex];
    _list.removeAt(deletedProductIndex);
    notifyListeners();
    print('Deleted From List');
    final response = await http.delete(url);
    print(response.statusCode);
    if(response.statusCode >=400)
      {
        print('Deleted From Database');
        _list.insert(deletedProductIndex, deletedProductData);
        notifyListeners();
        throw FlutterException("Can not Delete Product");
      }
    deletedProductData=null;
  }

  Future<void> fetchAndShowProduct() async
  {
    try
    {
      final response = await http.get(Uri.parse(URL));
      final extractedData  = json.decode(response.body) as Map<String , dynamic> ;
      List<Product> loadedProduct = [];
      print(jsonDecode(response.body));
      extractedData.forEach((productid, productData) {
        if (extractedData==null) {
          return;
        }
        loadedProduct.add
          (
            Product(product_name: productData['title']??"",
                price: productData['price']??"",
                id: productid,
                product_description: productData['description']??"",
                imageURL: productData['imageUrl']??"",
            )
        );
         _list = loadedProduct;
      });


       notifyListeners();
    }
    catch (error)
    {
      throw(error);

    }
  }
}
