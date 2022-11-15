// ignore_for_file: prefer_const_constructors, file_names, unused_local_variable, prefer_const_literals_to_create_immutables, unused_import, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/layout/Shop_App/cubit/cubit.dart';
import 'package:market/layout/Shop_App/cubit/states.dart';
import 'package:market/modules/Search/Search_Screen.dart';
import 'package:market/modules/Settings/Setting_Screen.dart';
import 'package:market/modules/login_screen/LoginShopScreen.dart';
import 'package:market/shared/Components/components.dart';
import 'package:market/shared/network/local/Cache_helper.dart';

import '../../modules/Carts/Cart_Screen.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,shopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit=ShopCubit.get(context);
        return
        Scaffold(

        appBar: AppBar(
          title: Text('Salla'),
          actions: [
            IconButton(onPressed: (){
               navigateTo(context, SearchScreen());
            }, icon: Icon(Icons.search)),
            // IconButton(onPressed: (){
            //   navigateTo(context, CartScreen());
            // }, icon: Icon(Icons.shopping_cart)),
          ],
        ),
        //   drawer: Drawer(
        //   width: 270.0,
        //   elevation: 20.0,
        //
        //   child:ListView(
        //
        //     physics: BouncingScrollPhysics(),
        //     children: [
        //       DrawerHeader(
        //         decoration: BoxDecoration(color: Colors.teal[700]),
        //         child:  Column(
        //           children: [
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.end,
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 CircleAvatar(
        //                   radius: 40.0,
        //                   backgroundImage: NetworkImage('https://media.istockphoto.com/id/1200677760/photo/portrait-of-handsome-smiling-young-man-with-crossed-arms.jpg?s=612x612&w=is&k=20&c=VeTdYDF-4Gl9EZ8RxTNtjRlazEjJGiXmEmVZz5mSLck='),
        //                 ),
        //                 SizedBox(width: 15.0,),
        //                 Expanded(
        //                   child: Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Column(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Text(
        //                           '${cubit.UserData!.data!.name}',
        //                           maxLines: 2,
        //                           overflow: TextOverflow.ellipsis,
        //                           style:
        //                           TextStyle(
        //                               fontSize: 15.0,
        //                               fontWeight: FontWeight.bold,
        //                               fontFamily: 'NUnit',
        //                               color: Colors.white
        //                           ),
        //                         ),
        //                         SizedBox(
        //                           height: 5.0,
        //                         ),
        //                         Text(
        //                           ' ${cubit.UserData!.data!.email}',
        //                           maxLines: 2,
        //                           overflow: TextOverflow.ellipsis,
        //
        //                           style:
        //                           TextStyle(
        //                               fontSize: 12.0,
        //                               fontWeight: FontWeight.w400,
        //                               fontFamily: ' NUnit',
        //                               color: Colors.white
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //                 // CircleAvatar(
        //                 //     child: IconButton(
        //                 //         onPressed: () {
        //                 //           navigateTo(
        //                 //               context, SettingsScreen());
        //                 //         },
        //                 //         icon: Icon(Icons.edit))),
        //               ],
        //             ),
        //             SizedBox(height: 10.0,),
        //             Row(
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               mainAxisAlignment: MainAxisAlignment.end,
        //               children: [
        //                 Text(
        //                   'Points : ${cubit.UserData?.data!.points}',
        //                   maxLines: 1,
        //                   overflow: TextOverflow.ellipsis,
        //                   style:
        //                   TextStyle(
        //                       fontSize: 12.0,
        //                       fontWeight: FontWeight.w500,
        //                       fontFamily: 'NUnit',
        //                       color: Colors.white
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   width: 15.0,
        //                 ),
        //                 Text(
        //                   'Credit : ${cubit.UserData?.data!.credit}',
        //                   maxLines: 1,
        //                   overflow: TextOverflow.ellipsis,
        //                   style:
        //                   TextStyle(
        //                       fontSize: 15.0,
        //                       fontWeight: FontWeight.w500,
        //                       fontFamily: 'NUnit',
        //                       color: Colors.white
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //       ListTile(
        //         title: Text('Home',
        //         style: TextStyle(fontSize: 18.0),),
        //         onTap: (){
        //           Navigator.pop(context);
        //         },
        //         leading: Icon(Icons.home),
        //       ),
        //       ListTile(
        //         title: Text(
        //           'Setting',
        //           style: TextStyle(fontSize: 18.0),
        //         ),
        //         onTap: () {
        //           //Navigator.pop(context);
        //          // navigateTo(context, SettingsScreen());
        //         },
        //         leading: Icon(Icons.settings),
        //       ),
        //
        //     ],
        //   ),
        // ),
          body: cubit.bottomScreen[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          onTap: (index)
          {
            cubit.changeBottom(index);
          },
          currentIndex: cubit.currentIndex,
          items:
        [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,),
            label: 'Home'

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps,),
            label: 'Categories'

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,),
            label: 'Favorite'

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart,),
              label: 'Cart'

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,),
            label: 'Profile'

          ),
        ],
        ),
      );
      },

    );
  }
}