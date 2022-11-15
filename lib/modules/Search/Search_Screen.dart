// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, body_might_complete_normally_nullable, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/modules/Search/Cubit/cubit.dart';
import 'package:market/modules/Search/Cubit/states.dart';
import 'package:market/shared/Components/components.dart';
import 'package:market/shared/style/colors.dart';

class SearchScreen extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var SearchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit,SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // var cubit=SearchCubit.get(context);
        return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                  DefaultFormField(
                    controller: SearchController,
                     validate: ( value)
                     {
                        if(value!.isEmpty)
                        {
                          return'Enter Text To Search';
                        }
                        return null;
                     },
                     onSubmit: (text) {
                      SearchCubit.get(context).Search(text!);
                     },
                      type: TextInputType.text,
                       label: 'Search',
                        prefix: Icons.search),
                        SizedBox(
                          height: 10.0,
                        ),
                        if(state is SearchLoadingStates)
                        LinearProgressIndicator(
                          color: defaultColor,
                        ),
                        SizedBox(height: 15.0,),
                        if(state is SearchSuccessStates)
                        Expanded(
                          child: ListView.separated(
                                          itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).searchModel?.data!.data![index],context),
                                          separatorBuilder:(context, index) =>mydivider(),
                                          itemCount:SearchCubit.get(context).searchModel!.data!.data!.length,
                                      ),
                        )
              ],
            ),
          ),
        ),
      );
      },

    );
  }
}