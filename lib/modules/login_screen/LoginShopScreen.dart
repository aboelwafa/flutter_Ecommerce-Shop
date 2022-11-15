// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, body_might_complete_normally_nullable, avoid_print, unused_import, import_of_legacy_library_into_null_safe

// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market/layout/Shop_App/Shop_Layout_Screen.dart';
import 'package:market/modules/Register_screen/RegisterShopScreen.dart';
import 'package:market/modules/login_screen/Login_Cubit/cuibt.dart';
import 'package:market/modules/login_screen/Login_Cubit/state.dart';
import 'package:market/shared/Components/components.dart';
import 'package:market/shared/Components/constants.dart';
import 'package:market/shared/network/local/Cache_helper.dart';

class ShopLogin extends StatelessWidget {

var emailController=TextEditingController();
var passwordController=TextEditingController();
var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopLoginCubit() ,
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context, state)  {
          // هنا بتاكد الشرط اتحقق 
          if(state is ShopLoginSucessStates)
          {
            if(state.loginModel.status) {
             print(state.loginModel.message);
             print(state.loginModel.data!.token);
             cacheHelper.saveData(
              key: 'token',
               value: state.loginModel.data!.token
               ).then((value)
               {
                token=state.loginModel.data!.token;
                navigateAndFinish(context, ShopLayout());
               });
              showToast(
                text: "${state.loginModel.message}",
                 state:Toaststate.SUCCESS 
                 );

            }
            else
            {
                print(state.loginModel.message);
             showToast(
              text: "${state.loginModel.message}",
               state: Toaststate.ERROR
               );
            // not work else
            }
          }
          
        },
        builder: (context, state) {
          var cubit=ShopLoginCubit.get(context);
          return
          Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text('LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600
                          ),
                          ),
                        ),
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Image(
                                image: NetworkImage(
                                  'https://media.istockphoto.com/id/1431031527/photo/mobile-banking-people-hand-payment-and-online-shopping-mobile-with-mobile-smart-phone-on-desk.jpg?s=1024x1024&w=is&k=20&c=hx9yZYu494ucQfr0c-6xFvZ5rtb8t6GjT_-PAqFUSnA='
                                  ,),

                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text('login now to browse our hot offer',

                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.white,
                                      fontSize: 17.0,

                                  ),
                                ),
                              ),
                            ],
                          ),

                        ),
                        SizedBox(height: 30.0,),
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
                              suffix: cubit.suffix,
                              SuffixPress: () {
                                cubit.ChangePassword();
                              },
                              onSubmit: (value) {
                                 if(formkey.currentState!.validate())
                                    {
                                      cubit.userLogin(
                                    email: emailController.text,
                                     password: passwordController.text
                                     );
                                    }
                              },
                              validate:(value) {
                                if(value!.isEmpty){
                                  return ' pleasr Enter your Password ';
                                }
                              },
                              IsPassword: cubit.IsPassword,
                                
                                
                              ),
                              SizedBox(height: 40.0,),
                              ConditionalBuilder(
                                // 
                                condition: state is! ShopLoginLoadingStates ,
                                builder: (context) => defaultButton(
                                  function: (){
                                    if(formkey.currentState!.validate()==true)
                                    {
                                      ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                     password: passwordController.text
                                     );
                                    }
                                  },
                                   text: 'LOGIN'),
                                   fallback: (context) => Center(child: CircularProgressIndicator()),
        
                              ),
                                SizedBox(height: 20.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Don\'t have an account?',style: TextStyle(color: Colors.black,fontSize: 20.0),),
                                      SizedBox(width: 20.0,),
                                    defaultTextButton(
                                    function: () {
                                      navigateTo(context, RegisterShop());
                                    },
                                    text: 'register',
                                    ),
                                  ],
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