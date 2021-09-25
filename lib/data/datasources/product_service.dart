import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:u_commerce/data/models/models.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  final String _baseUrl = 'flutter-u-commerce-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  bool isLoading = true;
  bool isSaving = false;
  late Product selectedProduct;

  ProductService() {
    this.loadProducts();
  }
  //TODO:
  Future<List<Product>> loadProducts() async {
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

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      //Es necesario crear un producto
      await this.createProduct(product);
    } else {
      //actualizar
      await this.updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'Products/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());
    final decodeData = resp.body;
    print(decodeData);

    //Actualizar lista de productos
    final index =
        this.products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'Products.json');
    final resp = await http.post(url, body: product.toJson());
    final decodeData = json.decode(resp.body);
    product.id = decodeData['name'];

    this.products.add(product);

    return product.id!;
  }
}
