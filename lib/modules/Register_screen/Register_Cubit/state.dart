// ignore_for_file: non_constant_identifier_names

import 'package:market/models/Shop_App/Login_Model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterIntialStates extends ShopRegisterStates{}

class ShopRegisterLoadingStates extends ShopRegisterStates{}

class ShopRegisterSucessStates extends ShopRegisterStates{
   final shopLoginModel LoginModel;

   ShopRegisterSucessStates(this.LoginModel);
}

class ShopRegisterErrorStates extends ShopRegisterStates{
  // final String error;

  // ShopRegisterErrorStates(this.error);
}

class ChangePasswordVisibalityState extends ShopRegisterStates{}
