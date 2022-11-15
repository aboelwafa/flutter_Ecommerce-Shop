// ignore_for_file: file_names, camel_case_types, unnecessary_null_in_if_null_operators, null_check_always_fails

class shopLoginModel
{
   late bool status;
   String? message;
    UserData? data;
//  named constructor
  shopLoginModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
    data = json['data'] =UserData.fromJson(json['data'])  ;
    
    // data لو مش بنل هات الداتا دي فجيسون 

  }
}
class UserData 
{
 int? id;
 String? name;
 String? email;
 String? phone;
 String? image;
dynamic points;
dynamic credit;
  String? token;

// constructor
// مش هستخدمه هعمله كومنت 
// UserData({
//  required this.id,
//  required this.name,
//  required this.email,
//  required this.phone,
//  required this.image,
//  required this.points,
//  required this.credit,
//  required this.token,

// });
// named constructor
  UserData.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    points=json['id'];
    credit=json['credit'];
    token=json['token'];

  }
}