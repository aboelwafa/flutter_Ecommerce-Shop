// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/shared/Components/components.dart';

import '../../layout/Shop_App/cubit/cubit.dart';
import '../../layout/Shop_App/cubit/states.dart';
import 'package:market/modules/Payment/Payment.dart';
class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return BlocConsumer<ShopCubit,shopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return
          ConditionalBuilder(
            condition: ShopCubit.get(context).getCartModel.data != null,
            builder: (context) =>
                SingleChildScrollView(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 120.0,
                                  child: Row(
                                    children: [
                                      Stack(
                                        alignment: AlignmentDirectional.bottomStart,
                                        children: [
                                          Image(
                                            image: NetworkImage('${ShopCubit.get(context).getCartModel.data?.cartItems[index]?.product!.image}'),
                                            width: 120.0,
                                            height: 120.0,

                                          ),
                                          if(ShopCubit.get(context).getCartModel.data?.cartItems[index]?.product!.discount!=0)
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
                                              '${ShopCubit.get(context).getCartModel.data?.cartItems[index]?.product!.name}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                height: 1.9,
                                              ),
                                            ),
                                            Spacer(),
                                            Row(
                                              children: [

                                                Text(
                                                  '${ShopCubit.get(context).getCartModel.data?.cartItems[index]?.product!.price} LE',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.black,
                                                  ),

                                                ),
                                                SizedBox(width: 3.0,),
                                                if(ShopCubit.get(context).getCartModel.data?.cartItems[index]?.product!.discount!=0)
                                                  Text(
                                                    '${ShopCubit.get(context).getCartModel.data?.cartItems[index]?.product!.oldPrice} LE',
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.grey[700],
                                                        decoration: TextDecoration.lineThrough
                                                    ),
                                                  ),
                                                Spacer(),
                                                IconButton(
                                                    icon:CircleAvatar(
                                                      radius: 25.0,
                                                      backgroundColor: ShopCubit.get(context).carts[ShopCubit.get(context).getCartModel.data?.cartItems[index]?.product!.id]! ?Colors.redAccent :Colors.grey ,
                                                      // backgroundColor: Colors.greenAccent,
                                                      child: Icon(
                                                        Icons.add_shopping_cart,
                                                        size: 20.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    onPressed: (){
                                                      ShopCubit.get(context).changeCarts(ShopCubit.get(context).getCartModel.data?.cartItems[index]?.product!.id);
                                                      // print(ShopCubit.get(context).getCartModel.data?.cartItems[index]?.id;
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
                              ],

                            ),

                          ),
                      separatorBuilder:(context, index) =>mydivider(),
                      itemCount:ShopCubit.get(context).getCartModel.data!.cartItems.length
                  ),
                    mydivider(),

                  SizedBox(height: 60.0,),
                  defaultButton(function: (){},
                      text:('TotalPrice=${ShopCubit.get(context).getCartModel.data?.total} LE'),
                          height: 50,
                    radius: 30.0,
                      width: 300.0,
                    isUpperCase: true,
                    background: Colors.blue

                  ),
                  SizedBox(height: 10.0,),
                  defaultButton(
                    function: (){
                    ShopCubit.get(context).UpdateOrders();
                    showToast(
                      text:ShopCubit.get(context).addOrderModel!.message!,
                      state:Toaststate.SUCCESS,
                    );
                    if(state is ShopSuccessAddOrderState)
                    {
                      ShopCubit.get(context).getCarts();
                      navigateTo(context, PaymentScreen());
                    }
                  },
                    text:('Check Now'),
                    height: 50,
                    radius: 30.0,
                    width: 300.0,
                    isUpperCase: true,
                    background: Colors.green,
                  )

                ],
              ),
            ),
           fallback: (context) => Center(child: CircularProgressIndicator()),
          );
      },



    ) ;
  }
}