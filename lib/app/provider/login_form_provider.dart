import 'package:flutter/material.dart';


class LoginFormProvider extends ChangeNotifier{

  GlobalKey<FormState> formKey= new GlobalKey<FormState>();
  
  String identificacion = '';
  String password = '';
  bool _isLoagind = false;

  //Getters and Setters
  bool get isLoading => _isLoagind;

  set isLoading (bool value){
    this._isLoagind = value;
    notifyListeners();
  }

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }


}