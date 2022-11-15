// ignore_for_file: prefer_const_constructors, duplicate_ignore, deprecated_member_use, unused_local_variable, avoid_print, empty_constructor_bodies, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, curly_braces_in_flow_control_structures, non_constant_identifier_names, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/layout/Shop_App/Shop_Layout_Screen.dart';
import 'package:market/layout/Shop_App/cubit/cubit.dart';
import 'package:market/layout/Shop_App/cubit/states.dart';
import 'package:market/modules/login_screen/LoginShopScreen.dart';
import 'package:market/modules/on_boarding_screen/on_boarding_screen.dart';
import 'package:market/shared/bloc_observed.dart';
import 'package:market/shared/network/local/Cache_helper.dart';
import 'package:market/shared/network/remote/Dio_helper.dart';

import 'modules/Search/Cubit/cubit.dart';

void main() async {
  // الميثود دي عشان 
  //main بقا async
  //فكدا ضمنت ان اي حاجة ف المين هتتنفذ

  WidgetsFlutterBinding.ensureInitialized();

Bloc.observer=MyBlocObserver();
  DioHelper.init();
 await cacheHelper.init();
  Widget widget;
 bool? onBoarding=cacheHelper.getData(key: 'onBoarding');
  String? token=cacheHelper.getData(key: 'token') !=null ?cacheHelper.getData(key: 'token'):null;
  //  token = CacheHelper.importData(key: 'token') != null ?CacheHelper.importData(key: 'token') :null;
  // String? email=cacheHelper.getData(key: 'email');
  if(onBoarding !=null)
  {
    if(token!=null)widget =ShopLayout();
    else widget =ShopLogin();
  }
  else{
    widget =OnBoardingScreen();
  }

 print(token);
  // print(email);
  runApp( MyApp(
    StartWidget: widget,
    ));
}

class MyApp extends StatelessWidget {
   late final bool onBoarding;
   late final Widget StartWidget;
MyApp(
  {
   required this.StartWidget,
  }
);
  @override

  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>ShopCubit()
        ..getHomeData()
        ..getCategoryData()
        ..getFavorites()
        ..getUserData()
          ..getCarts()

        ),
        BlocProvider(create: (context)=>SearchCubit(),),
      ],
      child: BlocConsumer<ShopCubit,shopStates>(
         listener  : (context, state) {},
        builder: (context, state) {
        return
        MaterialApp(
          debugShowCheckedModeBanner: false,
            theme:ThemeData(
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  // actionsIconTheme: IconThemeData(
                  //   color:Colors.teal,
                  // ),
                backgroundColor:Colors.white,
                elevation: 0.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.teal[700],
                statusBarIconBrightness: Brightness.light,
                  ),
                  titleTextStyle: TextStyle(
                    color: Colors.teal[800],
                    fontWeight: FontWeight.w900,
                    fontSize: 25.0,
                    fontFamily: 'NUnit',
                  ),
                  centerTitle: true,
                  iconTheme: IconThemeData(
                    color: Colors.teal[800],
                    size: 30.0
                  ),
                ),
                // body text
                    textTheme: const TextTheme(
                      bodyText2: TextStyle(
                        color: Colors.teal,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'NUnit',

                      ),
                      ),
              inputDecorationTheme: const InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 4, color: Colors.tealAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 4, color: Colors.teal),
                ),
              ),


                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  unselectedIconTheme: IconThemeData(
                    color: Colors.teal[300],
                    size: 30.0
                  ),
                  selectedIconTheme: IconThemeData(size: 35.0,color: Colors.teal[700],),
                 showUnselectedLabels: true,
                 elevation: 20.0,

                ),

            ) ,
          home:StartWidget ,
        );
        },
      ),
    );
  }


}

