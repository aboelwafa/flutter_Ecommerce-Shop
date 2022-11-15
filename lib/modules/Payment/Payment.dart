// ignore_for_file: prefer_const_constructors, file_names, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:market/shared/Components/components.dart';

import '../SuccessPay/Success.dart';
class PaymentScreen extends StatefulWidget {

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();


}

class _PaymentScreenState extends State<PaymentScreen> {
  int value=0;
  final paymentLabel=[
    'Credit Card / Debit Card',
    'Cash on Delivery',
    'paypal',
    'Google Wallet'
  ];
  final paymentIcon=[
    Icons.credit_card,
    Icons.money_off,
    Icons.payment,
    Icons.account_balance_wallet,
  ];
  @override
  Widget build(BuildContext context) {

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Payment',style: TextStyle(color: Colors.blue),),
          ),
          body:Column(
            children: [
              Text('Choose your payment Method',style: TextStyle(color: Colors.blueGrey,fontSize: 20.0),),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index){
                      return ListTile(
                        leading: Radio(
                          groupValue: value,
                            value: index,
                            activeColor: Colors.blue,
                          onChanged: (i) => setState(() =>value = index),
                        ),
                        title: Text(paymentLabel[index]),
                        trailing: Icon(paymentIcon[index],color: Colors.blue,),
                      );
                    },
                    separatorBuilder:(context, index) =>  mydivider(

                    ),
                    itemCount: paymentLabel.length),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultButton(function: (){
                    navigateTo(context, Success());
                }, text: 'pay',
                background: Colors.blue,
                  radius: 30,

                ),
              ),
            ],
          ) ,
        );




  }
}