import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import 'package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart';

import '../constants.dart';


class EditUserInfoView extends StatelessWidget {
  static String id = 'edit_user_info_view';
  const EditUserInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(elevation: 0 , backgroundColor: Colors.black12.withOpacity(.1) , title: const Text('Edit User Info',style:tAppBar ,)),
      body: Column(
        children: [
         const Spacer(flex: 6,),
          Container(
            width: MediaQuery.of(context).size.width/3, // Set the width according to your desired fit
            height: MediaQuery.of(context).size.height/8, // Set the height according to your desired fit
            decoration:const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/imgs/p2.png'),
                fit: BoxFit.cover, // Adjust the fit property as needed
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(child: Column(children: [
              CustomTextFormField(label: 'name',padding: 8,hint: 'Ali Mohammed'),
              CustomTextFormField(label: 'email',padding: 8,hint: 'example@gmail.com',),
              CustomTextFormField(label: 'phone',padding: 8,hint: '+970598891656',),

            ],)),
          ),
          const Spacer(flex: 6,),
          SecondaryButtonWidget(
            onTap:(){

            },
            text: 'Save',

            width: MediaQuery.of(context).size.width / 2.5,

          ),
          const Spacer(flex: 10,)
        ],
      ) ,
    );
  }
}
