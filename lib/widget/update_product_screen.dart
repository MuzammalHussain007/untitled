import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/modal/products.dart';
import 'package:untitled/providers/product_provider.dart';

class UpdateProductScreen extends StatefulWidget {
  static const routeName = '/update-product';

  @override
  _UpdateProductScreen createState() => _UpdateProductScreen();
}

class _UpdateProductScreen extends State<UpdateProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: '',
    product_name: '',
    price: 0,
    product_description: '',
    imageURL: '',
  );

  var initValue = {
    'id':'',
    'product_name' : '',
    'price' : '',
    'product_description' : '',
    'imageURL' : ''
  };
  late  bool _initState=true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    if (_form.currentState!.validate())
    {
      _form.currentState!.save();
      print(_editedProduct.product_name);
      print(_editedProduct.product_description);
      print(_editedProduct.price);
      print(_editedProduct.imageURL);
    }
    if (_editedProduct.id !=null) {
      context.read<Product_provider>().updateProduct(_editedProduct.id,_editedProduct);
    }else
      {
        context.read<Product_provider>().addProduct(_editedProduct);
      }

    Navigator.of(context).pop();

  }
  @override
  void didChangeDependencies() {
    if (_initState) {
      final productid = ModalRoute.of(context)?.settings.arguments as String;
      _editedProduct = context.read<Product_provider>().findByID(productid);
      initValue = {
        'id':_editedProduct.id,
        'product_name' : _editedProduct.product_name,
        'price' : _editedProduct.price.toString(),
        'product_description' : _editedProduct.product_description,
        'imageURL' : ''
      };
      _imageUrlController.text = _editedProduct.imageURL;
      print(productid);
    }
    _initState=false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: initValue['product_name'],
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value){
                  if (value.toString().isEmpty) {
                    return 'Fill the Title';
                  }else
                    {
                      return null;
                    }
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    product_name: value.toString(),
                    price: _editedProduct.price,
                    product_description: _editedProduct.product_description,
                    imageURL: value.toString(),
                      id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite
                  );
                },
              ),
              TextFormField(
                initialValue: initValue['price'],
                decoration: const InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value)
                {
                  if(value.toString().isEmpty){
                    return 'Fill Price';
                  }
                  if(double.tryParse(value.toString())==null){
                    return 'Please Enter Valid Number';
                  }
                  if (double.parse(value.toString()) <=0) {
                    return 'Please Enter  Number greater then zero';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    product_name: _editedProduct.product_name,
                    price: double.parse(value.toString()),
                    product_description: _editedProduct.product_description,
                    imageURL: value.toString(),
                      id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite
                  );
                },
              ),
              TextFormField(
                initialValue: initValue['product_description'],
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value){
                  if (value.toString().isEmpty) {
                    return 'Please enter description';
                  }
                  if (value.toString().length < 10) {
                    return 'Should be 10 character long';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    product_name: _editedProduct.product_name,
                    price: _editedProduct.price,
                    product_description: value.toString(),
                    imageURL: value.toString(),
                    id: _editedProduct.id,
                    isFavourite: _editedProduct.isFavourite
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Enter a URL')
                        : FittedBox(
                      child: Image.network(
                        _imageUrlController.text,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: (value){
                        if (value.toString().isEmpty) {
                          return 'Enter a valid URL';
                        }
                        if(!value.toString().startsWith('http') && !value.toString().startsWith('https')){
                             return 'Enter valid URL';
                        }
                        if(!value.toString().endsWith('.png') && !value.toString().endsWith('jpg')&& !value.toString().endsWith('jpeg')){
                          return 'Enter valid URL';
                        }
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          product_name: _editedProduct.product_name,
                          price: _editedProduct.price,
                          product_description: _editedProduct.product_description,
                          imageURL: value.toString(),
                            id: _editedProduct.id,
                            isFavourite: _editedProduct.isFavourite
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
