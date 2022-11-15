// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, import_of_legacy_library_into_null_safe, unused_import, body_might_complete_normally_nullable, unnecessary_type_check, avoid_print

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/layout/Shop_App/Shop_Layout_Screen.dart';
import 'package:market/layout/Shop_App/cubit/cubit.dart';
import 'package:market/layout/Shop_App/cubit/states.dart';
import 'package:market/modules/Register_screen/Register_Cubit/cuibt.dart';
import 'package:market/modules/Register_screen/Register_Cubit/state.dart';
import 'package:market/modules/login_screen/Login_Cubit/cuibt.dart';
import 'package:market/modules/login_screen/Login_Cubit/state.dart';
import 'package:market/shared/Components/components.dart';
import 'package:market/shared/Components/constants.dart';
import 'package:market/shared/network/local/Cache_helper.dart';

import '../login_screen/LoginShopScreen.dart';

class RegisterShop extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
    var phoneController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>ShopRegisterCubit() ,
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context, state) {
           if(state is ShopRegisterSucessStates)
          {
            if(state.LoginModel.status){
             print(state.LoginModel.message);
             print(state.LoginModel.data!.token);
             cacheHelper.saveData
               (
                 key: 'token',
                 value: state.LoginModel.data!.token
             ).then((value)
               {
                token=state.LoginModel.data!.token;
                navigateAndFinish(context, ShopLogin());
               });
              showToast(
                text: "${state.LoginModel.message}",
                 state:Toaststate.SUCCESS 
                 );
            }
            else{
                print(state.LoginModel.message);
             showToast(
              text: "${state.LoginModel.message}",
               state: Toaststate.ERROR
               );
            // not work else
            }

        }
        },
        builder: (context, state) {
          
          return Scaffold(
          appBar: AppBar(),
          body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('REGISTER',
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w600
                            ),
                            ),
                            SizedBox(height: 20.0,),
                            Text('Register now to browse our hot offer',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey[700]
                              
                            ),
                            ),
                            SizedBox(height: 30.0,),
                             DefaultFormField(
                              controller: nameController,
                                type: TextInputType.name,
                                 label: 'User Name',
                                  prefix: Icons.person,
                                  validate:(value) {
                                    if(value!.isEmpty)
                                    {
                                      return ' pleasr Enter your Name ';
                                    }
                                  }, 
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                            DefaultFormField(
                              controller: emailController,
                                type: TextInputType.emailAddress,
                                 label: 'Email',
                                  prefix: Icons.email,
                                  validate:(value) {
                                    if(value!.isEmpty)
                                    {
                                      return ' pleasr Enter your Email ';
                                    }
                                  }, 
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                   DefaultFormField(
                              controller: passwordController,
                                type: TextInputType.visiblePassword,
                                 label: 'Password',
                                  prefix: Icons.lock,
                                  suffix: ShopRegisterCubit.get(context).suffix,
                                  SuffixPress: () {
                                    ShopRegisterCubit.get(context).changepassword();
                                  },
                                  onSubmit: (value) {
                                     
                                  },
                                  validate:(value) {
                                    if(value!.isEmpty){
                                      return ' pleasr Enter your Password ';
                                    }
                                  },
                                  IsPassword: ShopRegisterCubit.get(context).ispassword,
                                    
                                    
                                  ),
                                  SizedBox(height: 20,),
                                  DefaultFormField(
                              controller: phoneController,
                                type: TextInputType.phone,
                                 label: 'Phone',
                                  prefix: Icons.phone,
                                  validate:(value) {
                                    if(value!.isEmpty)
                                    {
                                      return ' pleasr Enter your Phone ';
                                    }
                                  }, 
                                  ),
                                  SizedBox(height: 40.0,),

                                  ConditionalBuilder(
                                    // 
                                     condition: state is! ShopRegisterLoadingStates ,
                                    builder: (context) => defaultButton(
                                      function: (){
                                        if(formkey.currentState!.validate())
                                        {
                                          ShopRegisterCubit.get(context).userRegister(
                                            name: nameController.text,
                                        email: emailController.text,
                                         password: passwordController.text,
                                         phone: phoneController.text,
                                         );
                                        }
                                      },
                                       text: 'register'),
                                       fallback: (context) => Center(child: CircularProgressIndicator()),
            
                                  ),
                                    
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        );
        },
        
      ),
    );
  }
}