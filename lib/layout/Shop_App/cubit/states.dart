
// ignore_for_file: camel_case_types, unused_import

import 'package:market/models/Shop_App/change_Favorites_model.dart';
import 'package:market/models/Shop_App/Login_Model.dart';
import 'package:market/models/Shop_App/change_Favorites_model.dart';
import 'package:market/models/Shop_App/Change_Cart_Model.dart';
import 'package:market/models/Shop_App/AddorderModel.dart';

abstract class shopStates{}
 class shopIntialState extends shopStates{}

   class shopBottomNavState extends shopStates{}

  class shopLoadingHomeState extends shopStates{}

   class shopSuccessHomeState extends shopStates{}
  
    class shopErrorHomeState extends shopStates{

      final String error;

       shopErrorHomeState(this.error);
    }
    // state GetCategory
     class shopSuccessCategoryState extends shopStates{}

   class shopErrorCategoryState extends shopStates{}
class shopChangeFavoritesState extends shopStates{}

class shopSuccessChangeFavoritesState extends shopStates{
 final ChangeFavoritesModel model;
 shopSuccessChangeFavoritesState(this.model);
}

class shopErrorChangeFavoritesState extends shopStates{}

class shopLoadingGetFavoritesState extends shopStates{}

class shopSuccessGetFavoritesState extends shopStates{}

class shopErrorGetFavoritesState extends shopStates{}

class shopLoadingUserDataState extends shopStates{}
//userData
class shopSuccessUserDataState extends shopStates{
 final shopLoginModel loginModel;
 shopSuccessUserDataState(this.loginModel);
}

class shopErrorUserDataState extends shopStates{}

//update userData
class shopLoadingUpdateUserDataState extends shopStates{}

class shopSuccessUpdateUserDataState extends shopStates{
 final shopLoginModel loginModel;
 shopSuccessUpdateUserDataState(this.loginModel);
}

class shopErrorUpdateUserDataState extends shopStates{}

//state for imageProfile
class shopSuccessProfileImageState extends shopStates{}


class shopErrorProfileImageState extends shopStates{}

//state cart
//  class ChangeCartColorState extends shopStates {}
//   class ChangeCartSuccessState extends shopStates {}
//  class ChangeCartErrorState extends shopStates {}

 class GetCartLoadingState extends shopStates {}
 class GetCartSuccessState extends shopStates {}
 class GetCartErrorState extends shopStates {}

class shopChangeCartsState extends shopStates{}
class shopSuccessChangeCartsState extends shopStates{
 final ChangeCartModel model;
 shopSuccessChangeCartsState(this.model);
}
class shopErrorChangeCartsState extends shopStates{}




// state order
class ShopLoadingGetOrderState extends shopStates{}
class ShopSuccessGetOrderState extends shopStates{}
class ShopErrorGetOrderState extends shopStates{}


class ShopSuccessAddOrderState extends shopStates{
 final AddOrderModel model;
 ShopSuccessAddOrderState(this.model);
}

class ShopErrorAddOrderState extends shopStates{}



// class ShopSearchLoadingStates extends shopStates{}

// class ShopSearchSuccessStates extends shopStates{}

// class ShopSearchErrorStates extends shopStates{}