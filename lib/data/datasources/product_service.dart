import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:u_commerce/data/models/models.dart';
import 'package:http/http.dart' as http;
class ProductService extends ChangeNotifier{

  final String _baseUrl = 'flutter-u-commerce-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  bool isLoading = true;
  late Product selectedProduct;


  ProductService(){
    this.loadProducts();
  } 
  //TODO: 
  Future<List<Product>>  loadProducts() async{

    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'Products.json');
    final resp = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(resp.body);
    
    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct);
    });
    
    this.isLoading = false;
    notifyListeners();
    return this.products;
  }


}