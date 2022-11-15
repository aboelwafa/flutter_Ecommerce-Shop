// ignore_for_file: prefer_const_constructors, file_names, sized_box_for_whitespace, import_of_legacy_library_into_null_safe, unused_import

import 'package:conditional_builder/conditional_builder.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/layout/Shop_App/cubit/cubit.dart';
import 'package:market/models/Shop_App/Favorites_model.dart';
import 'package:market/shared/Components/components.dart';
import 'package:market/shared/style/colors.dart';

import '../../layout/Shop_App/cubit/states.dart';

class FavouriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return  BlocConsumer<ShopCubit,shopStates>
        (
        listener: (context, state) {},
        builder: (context, state) {
          return
            ConditionalBuilder(
              condition: ShopCubit.get(context).favoritesModel.data != null,
              builder:(context) =>  ListView.separated(
                  itemBuilder: (context, index) => buildFavItem(ShopCubit.get(context).favoritesModel.data!.data![index].product!,context),
                  separatorBuilder:(context, index) =>mydivider()  ,
                  itemCount:ShopCubit.get(context).favoritesModel.data!.data!.length,
              ),

              fallback: (context) =>  Center(child: CircularProgressIndicator()),
            );

        },


      ) ;

  }
  Widget buildFavItem(model,context)=>Padding(
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
                      '${model.price.toString()} LE',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),

                    ),
                    SizedBox(width: 5.0,),
                    if(model.discount!=0)
                      Text(
                        '${model.oldPrice} LE',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey[600],
                            decoration: TextDecoration.lineThrough

                        ),

                      ),
                    Spacer(),
                    IconButton(

                        icon:CircleAvatar(
                          radius: 25.0,
                          backgroundColor: ShopCubit.get(context).favorites[model.id]! ?Colors.redAccent :Colors.grey ,
                          // backgroundColor: Colors.deepPurpleAccent,
                          child: Icon(
                            Icons.favorite_border,
                            size: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: (){
                            ShopCubit.get(context).changeFavorites(model.id);
                          // print(token);
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

}