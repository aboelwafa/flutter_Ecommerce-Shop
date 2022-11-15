// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, sized_box_for_whitespace, avoid_print, import_of_legacy_library_into_null_safe

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/layout/Shop_App/cubit/cubit.dart';
import 'package:market/layout/Shop_App/cubit/states.dart';
import 'package:market/models/Shop_App/Category_Model.dart';
import 'package:market/models/Shop_App/Home_Model.dart';
import 'package:market/shared/Components/components.dart';

class ProductScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,shopStates>
    (
      listener: (context, state) {
        if(state is shopSuccessChangeFavoritesState &&state is shopSuccessChangeCartsState)
        {
          if(!state.model.status)
          {
            showToast(
                text: "${state.model.message}",
                state: Toaststate.ERROR
            );
          }


        }
      },
      builder: (context, state) {
        return
          ConditionalBuilder(
         condition:ShopCubit.get(context).homeModel !=null &&ShopCubit.get(context).categoryModel !=null ,
           builder: (context) =>ProductsBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoryModel,context) ,
            fallback:(context) =>  Center(child: CircularProgressIndicator()),

            );
      },
    
     );

  }

  Widget ProductsBuilder(HomeModel model,CateogriesModel categoryModel,context)=>
  
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          CarouselSlider(
            items: model.data.banners.map((e) =>
            Image(image: NetworkImage('${e.image}'),
              width: double.infinity,
              height: 150.0,
              fit: BoxFit.cover,
              )
            ).toList(),
           options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 4),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
    
           )),
          SizedBox(
            height: 10.0,
          ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10.0),
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text('Categories',
                   style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                    // fontFamily: 'Nunito',

                   ),
                   ),
                   SizedBox(height: 10.0 ,),
                    Container(
                      height: 120.0,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoryItem(categoryModel.data!.data![index]),
                         separatorBuilder: (context, index) =>SizedBox(width: 5.0,) ,
                         itemCount: categoryModel.data!.data!.length
                         ),
                    ),
                    SizedBox(
                      height: 30.0,),
                    Text('New Products',
                   style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                   // fontFamily: 'Nunito',
                   ),
                   ),
                 ],
               ),
             ),
              SizedBox(
                height: 10.0,),
          Container(
            width: double.infinity,
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 1, //هيبقي فيه اتنين ع الصفحة منتجين جمب بعض
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1.0/0.95,// ,wid,length

              children: List.generate(model.data.products.length,
              (index) => buildGridProduct(model.data.products[index],context),
                  ),

              
              ),
          ),
      ],
      ),
    );

    Widget buildCategoryItem(DataCategoryModel model)=>
    Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image(image: NetworkImage('${model.image}'),
              width: 120.0,
              height: 100.0,
              fit: BoxFit.cover,
              
              ),
              Container(
                width: 120.0,
                color: Colors.black.withOpacity(0.6),
                child: Text('${model.name}',
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                ),
                )
                ),
            ],
          );

   Widget buildGridProduct(ProductModel model,context)=>
              Container(

                color: Colors.white,
                child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Image(
                          image: NetworkImage('${model.image}'),
                          width: double.infinity,
                          height: 190.0,

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
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${model.name}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20.0,
                              height: 2.9,
                            ),
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Text(
                                '${model.price.round()} LE',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                  //fontWeight: FontWeight.w600,
                                ),

                              ),
                              SizedBox(width: 10.0,),
                              if(model.discount!=0)
                                Text(
                                  '${model.oldPrice.round()} LE',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[700],
                                    decoration: TextDecoration.lineThrough,
                                   // fontWeight: FontWeight.w300,
                                  ),
                                ),
                              Spacer(),
                              IconButton(
                                  icon:CircleAvatar(
                                    radius: 25.0,
                                    backgroundColor: ShopCubit.get(context).carts[model.id]! ?Colors.redAccent :Colors.grey ,
                                    // backgroundColor: Colors.greenAccent,
                                    child: Icon(
                                      Icons.add_shopping_cart,
                                      size: 20.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: (){
                                    ShopCubit.get(context).changeCarts(model.id);
                                    print(model.id);
                                  }
                              ),
                              IconButton(
                                  icon:CircleAvatar(
                                    radius: 25.0,
                                    backgroundColor: ShopCubit.get(context).favorites[model.id]! ?Colors.redAccent :Colors.grey ,
                                    child: Icon(
                                      Icons.favorite_border,
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
}