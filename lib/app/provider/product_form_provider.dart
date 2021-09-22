

import 'package:flutter/material.dart';
import 'package:u_commerce/data/models/models.dart';

class ProductFormProvider extends ChangeNotifier{

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Product product;

  ProductFormProvider(this.product);

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }

}