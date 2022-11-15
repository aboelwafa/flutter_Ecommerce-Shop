// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:market/modules/login_screen/LoginShopScreen.dart';
import 'package:market/shared/Components/components.dart';
import 'package:market/shared/network/local/Cache_helper.dart';
        void singOut(context){
             cacheHelper.removeData(key: 'token').then((value) {
                if(value){
                    navigateAndFinish(context, ShopLogin());
                }
              });
}

void printFullText(String text)
{
  final Pattern=RegExp('.{1,800}');
  Pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}

String? token='Ol6lBTShzTAXXHNTciIuwhm76dahd9MXfHYml1rGrLu808zuVfe2ItG3Gvg4o7PSXq1FK4';
// String email='omar207@gmail.com';
