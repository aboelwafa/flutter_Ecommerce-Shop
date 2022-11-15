// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, unused_local_variable, unused_field, avoid_function_literals_in_foreach_calls, duplicate_import, non_constant_identifier_names
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/models/Shop_App/GetCartModel.dart';
import 'package:market/models/Shop_App/Change_Cart_Model.dart';
import 'package:market/layout/Shop_App/cubit/states.dart';
import 'package:market/models/Shop_App/Category_Model.dart';
import 'package:market/models/Shop_App/Favorites_model.dart';
import 'package:market/models/Shop_App/Home_Model.dart';
import 'package:market/models/Shop_App/Login_Model.dart';
import 'package:market/models/Shop_App/Search_model.dart';
import 'package:market/models/Shop_App/change_Favorites_model.dart';
import 'package:market/modules/Catogries/Catogries_Screen.dart';
import 'package:market/modules/Favourite/Favourite_Screen.dart';
import 'package:market/modules/Carts/Cart_Screen.dart';
import 'package:market/models/Shop_App/GetOrder_model.dart';
import 'package:market/models/Shop_App/AddorderModel.dart';
import 'package:market/modules/Products/Product_Screen.dart';
import 'package:market/modules/Settings/Setting_Screen.dart';
import 'package:market/shared/Components/constants.dart';
import 'package:market/shared/network/endPoint.dart';
import 'package:market/shared/network/remote/Dio_helper.dart';
import 'package:market/models/Shop_App/Login_Model.dart';
import 'package:market/layout/Shop_App/cubit/cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ShopCubit extends Cubit<shopStates>
{
  ShopCubit():super(shopIntialState());

 static ShopCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  //get
  List<Widget> bottomScreen=
  [
    ProductScreen(),
    CatogriesScreen(),
    FavouriteScreen(),
    CartScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex=index;
    emit(shopBottomNavState());
  }
       
  HomeModel? homeModel;
  Map<int?,bool?> favorites={};
  Map<int?,bool?> carts={};


  void getHomeData() {
    emit(shopLoadingHomeState());
    DioHelper.getData(
      url: HOME,
      token: token,
      ).then((value) {
      // print(value.data);
       homeModel=HomeModel?.fromJson(value.data);
      //  printFullText(homeModel.toString());
      //  print(homeModel.data!.banners[0].image);
       homeModel?.data.products.forEach((element) {
         favorites.addAll({
           element.id:element.inFav
         });
         carts.addAll({
           element.id:element.inCart
         });


       });
       print(favorites.toString());
       print(carts.toString());


       emit(shopSuccessHomeState());
    }).catchError((error){
      emit(shopErrorHomeState(error));
    });
  }
  
  late CateogriesModel categoryModel;
  getCategoryData() { 
        emit(shopLoadingHomeState());
    DioHelper.getData(
      url: Get_CATEGORIES,
      token: token,
      ).then((value) {
      // print(value.data);
        categoryModel=CateogriesModel.fromJson(value.data);
        // print(categoryModel.status);
        // print(categoryModel.data?.data![0].image);
      emit(shopSuccessCategoryState());
    }).catchError((error){
      emit(shopErrorCategoryState());
    });
  }

    // homemodel empty
  // get data home 

//   void getHomeData()
//  {
//     emit(shopLoadingHomeState());
//     DioHelper.getData(url: HOME).then((value)
//     {
//        print(value.data);
//        homeModel=HomeModel.fromjson(value.data);

//         printFullText(homeModel.data.banners.toString());
//       emit(shopSuccessHomeState());
//     }).catchError((error)
//     {
//         print(error.toString());
//        emit(shopErrorHomeState(error));

//     });
//  } 
// }

  late ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId]!;
    emit(shopChangeFavoritesState());

    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id':productId
        },
        token:token,
    )
        .then((value) {
          changeFavoritesModel=ChangeFavoritesModel.fromjson(value.data);
          print(value.data);
             if(!changeFavoritesModel.status)
             {
               favorites[productId] = favorites[productId]!;
             }
             else{
               getFavorites();
             }

              emit(shopSuccessChangeFavoritesState(changeFavoritesModel));
    })
        .catchError((error){
        print(error.toString());

        emit(shopErrorChangeFavoritesState());
    });
  }

  late FavoritesModel favoritesModel;
  getFavorites() {
    emit(shopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      // print(value.data);
      favoritesModel=FavoritesModel.fromJson(value.data);
      print(favoritesModel.toString());
      emit(shopSuccessGetFavoritesState());
    }).catchError((error){
      emit(shopErrorGetFavoritesState());
    });
  }


  late GetCartsModel getCartModel;
    getCarts() {
    emit(GetCartLoadingState());
    DioHelper.getData(
      url: CARTS,
      token: token,
    ).then((value) {
       //print(value.data);
     // cartsModel=GetCartModel.fromJson(value.data);
      print('ggggggggggggggggggg');
      getCartModel=GetCartsModel.fromJson(value.data);
      // print(getCartModel?.data);
      // print(getCartModel?.status);
      // print(getCartModel?.data?.total);
      // print(getCartModel?.data?.cartItems);

      //print(cartsModel?.data?.total);
      emit(GetCartSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetCartErrorState());
    });
  }

  late ChangeCartModel changeCartModel;
  void changeCarts(dynamic productId)
  {
    carts[productId] = !carts[productId]!;
    //change color icon
    emit(shopChangeFavoritesState());

    DioHelper.postData(
      url: CARTS,
      data: {
        'product_id':productId
      },
      token:token,
    )
        .then((value) {
      changeCartModel=ChangeCartModel.fromJson(value.data);
      //change color icon if status = false
      if(!changeCartModel.status)
      {
        carts[productId] = carts[productId]!;
      }
      else{
        getCarts();
      }
      print(value.data);
      emit(shopSuccessChangeCartsState(changeCartModel));
    })
        .catchError((error){
      carts[productId] = carts[productId]!;
      print(error.toString());
      emit(shopErrorChangeCartsState());
    });
  }

  late shopLoginModel? UserData;
   getUserData() {
    emit(shopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      UserData=shopLoginModel.fromJson(value.data);
      //printFullText(UserData.data!.name);
      emit(shopSuccessUserDataState(
          UserData!
      ));
    }).catchError((error){
      print(error.toString());
      emit(shopErrorUserDataState());
    });
  }

    void UpdateUserData(
        {
    required String name,
      required String email,
      required String Phone,
       String? image,
        })
    {

    emit(shopLoadingUpdateUserDataState());
    DioHelper.PutData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':Phone,
        'image':image,
      },

    ).then((value) {
      UserData=shopLoginModel.fromJson(value.data);
     // printFullText(UserData.data.name);
      emit(shopSuccessUpdateUserDataState(
          UserData!
      ));
    }).catchError((error){
      print(error.toString());
      emit(shopErrorUpdateUserDataState());
    });
  }

  //  late SearchModel searchModel;

  // void Search(String? text)
  // {
  //   emit(ShopSearchLoadingStates());
  //   DioHelper.postData(
  //     url: SEARCH,
  //     token: token,
  //    data: {
  //     'text':text
  //    }).then((value) {
  //     searchModel=SearchModel.fromJson(value.data);
  //     emit(ShopSearchSuccessStates());
  //    }).catchError((error){

  //     emit(ShopSearchErrorStates());
  //     print(error.toString());
  //    });
  // }
//get random number
  // get
  AddOrderModel? addOrderModel;
  void UpdateOrders()
  {
    emit(ShopLoadingGetOrderState());
    DioHelper.postData(
      url: ORDERS,
      data: {
        'address_id': 35,
        'payment_method':"1",
        'use_points': false,
      },
      token: token,
    ).
    then((value)
    {
      addOrderModel = AddOrderModel.fromJson(value.data);
      emit(ShopSuccessAddOrderState(addOrderModel!));
    }).
    catchError((error)
    {
      emit(ShopErrorAddOrderState());
    });
  }

  GetOrderModel? getOrderModel;
  void GetOrders()
  {
    emit(ShopLoadingGetOrderState());
    DioHelper.getData(
        url: ORDERS,
        token: token

    )
        .then((value)
    {
      getOrderModel= GetOrderModel.fromJson(value.data);
      // print(value.data);
      // print('sssssssssssssssssssssssssssssssssssssssssssss');
      emit(ShopSuccessGetOrderState());
    }).
    catchError((error)
    {
      emit(ShopErrorGetOrderState());
    });
  }


}