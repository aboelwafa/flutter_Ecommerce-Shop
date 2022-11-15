
// ignore_for_file: unused_import

import 'Home_Model.dart';

class ChangeCartModel
{
 late bool status;
  String? message;


  ChangeCartModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    message = json['message'];
  }
}

