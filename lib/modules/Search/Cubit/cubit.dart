// ignore_for_file: unnecessary_import, non_constant_identifier_names, avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:market/layout/Shop_App/cubit/cubit.dart';
import 'package:market/models/Shop_App/Search_model.dart';
import 'package:market/modules/Search/Cubit/states.dart';
import 'package:market/shared/Components/constants.dart';
import 'package:market/shared/network/endPoint.dart';
import 'package:market/shared/network/remote/Dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchIntialStates());
  static SearchCubit get(context)=>BlocProvider.of(context);
 late SearchModel? searchModel;

  void Search(String? text)
  {
    emit(SearchLoadingStates());
    DioHelper.postData(
      url: SEARCH,
      token: token,
     data: {
      'text':text
     }).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      emit(SearchSuccessStates());
     }).catchError((error){
      print(error.toString());
      emit(SearchErrorStates());
     });
  }
  
}