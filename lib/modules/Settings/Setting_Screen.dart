// ignore_for_file: prefer_const_constructors, file_names, file_names, duplicate_ignore, use_key_in_widget_constructors, must_be_immutable, unnecessary_null_comparison, import_of_legacy_library_into_null_safe
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';


import 'dart:io';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market/layout/Shop_App/cubit/cubit.dart';
import 'package:market/shared/Components/components.dart';
import 'package:market/shared/Components/constants.dart';
import 'package:market/shared/style/colors.dart';

import '../../layout/Shop_App/cubit/states.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var FormKey=GlobalKey<FormState>();

  var nameController=TextEditingController();

  var emailController=TextEditingController();

  var phoneController=TextEditingController();

  var ImageController=TextEditingController();

  late File? ProfImage;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        ProfImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
      if (ProfImage != null)
        isEdit = true;
    });
  }
  bool? isEdit = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,shopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
                   var model=ShopCubit.get(context).UserData;
                   nameController.text="${model?.data!.name!}";
                   emailController.text="${model?.data!.email!}";
                   phoneController.text="${model?.data!.phone!}";
                   ImageController.text="${model?.data!.image!}";

                return ConditionalBuilder(
               condition: ShopCubit.get(context).UserData != null,
               builder: (context)=>Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Form(
                     key: FormKey,
                     child: Column(

                       children: [

                         if(state is shopLoadingUpdateUserDataState)
                         LinearProgressIndicator(color: Colors.teal),
                         Container(
                           child: Stack(
                             alignment: AlignmentDirectional.bottomCenter,
                             children: [
                               Align (
                                 child: Container(

                                   width: double.infinity,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10.0),
                                     image: DecorationImage(
                                       image: NetworkImage('${model?.data!.image}'),
                                            fit: BoxFit.fill,
                                     ),
                                   ),
                                 ),
                                 alignment: AlignmentDirectional.topStart,
                               ),
                               CircleAvatar(
                                 radius: 64.0,
                                 backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                 child: Stack(
                                   alignment: AlignmentDirectional.bottomEnd,
                                   children: [
                                     if(isEdit==false)
                                     CircleAvatar(
                                       radius: 60.0,
                                       child:
                                       model?.data!.image !=null ? Image.file(File('${model?.data!.image}'))
                                           : Image(image: NetworkImage(
                                           'https://media.istockphoto.com/id/1431031527/photo/mobile-banking-people-hand-payment-and-online-shopping-mobile-with-mobile-smart-phone-on-desk.webp?s=612x612&w=is&k=20&c=MreL7_MtYXxJ3KBCDY1O3knCeYmv0pc-KWU-NZKekWI='),),

                               ),
                                     if(isEdit==true)
                                       CircleAvatar(
                                         radius: 60.0,
                                         child: ClipOval(child: Image.file(
                                           ProfImage!,fit:BoxFit.cover,height: 180,width: 180,),clipBehavior: Clip.hardEdge,)

                                       ),
                                     IconButton(onPressed: (){
                                       // ImageCubit.get(context).getProfileImage();
                                       setState(() {
                                         getImage();

                                       });
                                     },
                                         icon: CircleAvatar(
                                              backgroundColor: Colors.teal,
                                           radius: 20.0,
                                           child: Icon(
                                             Icons.camera_alt,
                                             color: Colors.white,

                                           ),
                                         ),
                                     ),
                                   ],
                                 ),
                               ),
                             ],
                           ),
                         ),
                         Text("${model?.data!.name}"),

                         SizedBox(height: 20.0,),
                         DefaultFormField(
                           controller: nameController,
                           validate: ( value){
                             if(value!.isEmpty){
                               return 'name must not be empty';
                             }
                             return null;
                           },

                           type: TextInputType.name,
                           label: 'Name',
                           prefix: Icons.person,
                         ),
                         SizedBox(
                           height: 20.0,
                         ),
                         DefaultFormField(
                           controller: emailController,
                           validate: ( value){
                             if(value!.isEmpty){
                               return 'email must not be empty';
                             }
                             return null;
                           },

                           type: TextInputType.emailAddress,
                           label: 'Email',
                           prefix: Icons.email_outlined,
                         ),
                         SizedBox(
                           height: 20.0,
                         ),
                         DefaultFormField(
                           controller: phoneController,
                           validate: ( value){
                             if(value!.isEmpty){
                               return 'phone must not be empty';
                             }
                             return null;
                           },

                           type: TextInputType.phone,
                           label: 'Phone',
                           prefix: Icons.call,
                         ),

                         SizedBox(
                           height: 20.0,
                         ),

                         defaultButton(
                          function: (){
                            singOut(context);
                          },
                           text: 'logout'
                           ),
                         SizedBox(
                           height: 10.0,
                         ),
                         defaultButton(
                             function: (){
                               if(FormKey.currentState!.validate())
                               {
                                 ShopCubit.get(context).UpdateUserData
                                   (
                                     name: nameController.text,
                                     email: emailController.text,
                                     Phone: phoneController.text,
                                     image: isEdit== true? ProfImage!.path:model?.data!.image
                                 );
                               }

                             },
                             text: 'Update'
                         ),

                       ],
                     ),
                   ),
                 ),

               fallback: (context) => Center(child: CircularProgressIndicator(
                 color: defaultColor,
               )),

             );
      },
    );
  }
}