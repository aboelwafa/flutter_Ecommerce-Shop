// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names, prefer_const_constructors, sort_child_properties_last, constant_identifier_names, dead_code, unused_local_variable, body_might_complete_normally_nullable, sized_box_for_whitespace, unused_import

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market/layout/Shop_App/cubit/cubit.dart';
import 'package:market/models/Shop_App/Favorites_model.dart';
import 'package:market/shared/style/colors.dart';


//  component to go name widget screen and back
void navigateTo(context,Widget)=> Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Widget,
    ),
  );
void navigatePop(context,Widget)=> Navigator.pop(
  context,
  MaterialPageRoute(builder: (context) => Widget,
  ),
);

  // component to go name widget screen and not back
  void navigateAndFinish
  (context,Widget)=>
   Navigator.pushAndRemoveUntil(
    context,
   MaterialPageRoute(
    builder: (context) => Widget,
    ),
    (route) {
      return false;
    },
  );
  // reusable component to textFormField
  // 2-TextFormField
Widget DefaultFormField({
  required TextEditingController controller,
  String? Function(String?)? onSubmit,
  String? Function(String?)? onChanged,
 required String? Function(String?)? validate,
 required TextInputType type,
  required String label,
  required IconData prefix,
   IconData? suffix,
   Function()? SuffixPress,
  bool IsPassword=false,
  Color suffixIconColor=Colors.teal
})=>
 
 TextFormField(
  controller: controller,
  onFieldSubmitted:onSubmit,
 onChanged: onChanged,
 validator: validate,
 keyboardType: type,
 obscureText: IsPassword,
 decoration: InputDecoration(
   // enabledBorder: OutlineInputBorder(
   //   borderSide: BorderSide(
   //     width: 5.0,
   //     color: Colors.teal
   //   ),
   // ),
 suffixIconColor: suffixIconColor,
 labelText: label,
 prefixIcon: Icon(prefix),
    suffixIcon: suffix!=null? IconButton(
      onPressed: SuffixPress,
      icon: Icon(
      Icons.remove_red_eye),
    )
  :null,
 border: OutlineInputBorder(),
                ),
                );  

// defaultButton
Widget defaultButton({
  double width=double.infinity,
  Color background =Colors.teal,
required void Function()? function, // Good
 required String text,
  double height=45.0,
 bool isUpperCase=true,
 double radius=10.0,
})=>
 Container(
  width: width,
  height: height,
  child: MaterialButton(
    onPressed:function,
    child:
     Text(
      isUpperCase?text.toUpperCase():text,
       style: TextStyle(
      color: Colors.white,
    ),),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
      color:background,


    ),

);
//TEXT BUTTON
// 
Widget defaultTextButton({
  required Function()? function,
  required String text,
})=>
TextButton(
    onPressed: function,
    child: Text(text.toUpperCase(),style: TextStyle(
        color: Colors.white,
        backgroundColor: Colors.teal,
        fontSize: 20.0,
    ),));

// flutter toast msg 

void showToast({
  required String text,
  required Toaststate state,
})=>Fluttertoast.showToast(
msg: text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
 timeInSecForIosWeb: 10,
backgroundColor:chooseToastcolor(state),
textColor: Colors.white,
fontSize: 20.0,
       );

      //  enum>> to swap color
enum Toaststate
{
  SUCCESS,
  ERROR,
  WARNING
}
// method change color
Color? chooseToastcolor(Toaststate state)
{ Color color;
  switch(state)
  {

    case Toaststate.SUCCESS:
    color= Colors.green;
    break;
    case Toaststate.ERROR:
    color= Colors.red;
    break;
    case Toaststate.WARNING:
    color= Colors.yellow;
    break;
  }
  return color;
}
      
Widget mydivider()=>Padding(


              padding: const EdgeInsetsDirectional.only(start: 20.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[700],
              ),
            );
              
 Widget buildListProduct( model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: 120.0,
                height: 120.0,
                fit: BoxFit.cover,

              ),
              if(model.discount!=0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text('DISCOUNT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 20.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15.0,
                    height: 1.5,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      style: TextStyle(
                        fontSize: 20.0,
                        color: defaultColor,
                      ),

                    ),
                    SizedBox(width: 5.0,),
                    if(model.discount!=0)
                      Text(
                        model.oldPrice.toString(),
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough

                        ),

                      ),
                    Spacer(),
                    IconButton(

                        icon:CircleAvatar(
                          radius: 25.0,
                          backgroundColor: ShopCubit.get(context).favorites[model.id]! ? Colors.pinkAccent :Colors.grey ,
                          child: Icon(
                            Icons.add_shopping_cart,
                            size: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: (){
                             ShopCubit.get(context).changeFavorites(model.id);
                        }
                    ),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    ),
  );              