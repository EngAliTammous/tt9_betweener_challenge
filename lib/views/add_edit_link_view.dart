import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/show_mixin.dart';
import 'package:tt9_betweener_challenge/views/home_view.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import 'package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart';

import '../constants.dart';
import '../controllers/user_controller.dart';
import '../models/user.dart';




class AddEditLinkView extends StatefulWidget {
   AddEditLinkView({super.key , this.refreshScreen , required this.checkAdd,this.idContainer});

  int? idContainer ;
  final bool checkAdd ;
  static String id = '/registerView';
  final Function()? refreshScreen ;
  @override
  State<AddEditLinkView> createState() => _AddEditLinkViewState();
}

class _AddEditLinkViewState extends State<AddEditLinkView> with Helpers {


  late TextEditingController _title ;
  late TextEditingController _link ;
   late FocusNode _titleFocus ;

  late Future<User> user;
  //late Future<List<Link>> links;


  @override
  void initState() {
    // TODO: implement initState
    user = getLocalUser();

    _title = TextEditingController();
    _link = TextEditingController();
_titleFocus = FocusNode();

    super.initState();
  }

@override
  void dispose() {
    // TODO: implement dispose
  _link.dispose();
  _title.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

   postData(String token) async {
  if(_formKey.currentState!.validate()) {
    try {
      showMessage(context, message: 'Wait seconds to add link ');

      await addNewLink(token, _title.text, _link.text);

      // You can process the addedLink response here if needed

      if (mounted) {
        FocusScope.of(context).unfocus();
        // Dismiss the keyboard
        showMessage(context, message: 'Added successfully ');

        Navigator.pop(context, true);
      }
    } catch (e) {
      showMessage(context, message: 'There problem , Check connection internet');
      print('Error adding link: $e');
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(elevation: 0 , backgroundColor: Colors.black12.withOpacity(.1) , title: widget.checkAdd? const Text('Add Link',style:tAppBar ,): const Text('Edit',style: tAppBar,),

      ) ,
      body: Padding(
        padding:const  EdgeInsets.symmetric(horizontal: 32.0),
        child:  Form(
          key: _formKey,
          child: Column(
            children: [
              const  Spacer(flex: 6,),

                 CustomTextFormField(
                   focusNode: _titleFocus ,
                   label: 'title',controller: _title,validator:(val){
                   if(val!.isEmpty){
                    return 'Please Enter Title';
                   }
                 } ,),
              //const SizedBox(height: 24,),
              const Spacer(),
                 CustomTextFormField(label: 'link',controller: _link , validator: (val){
                   if(val!.isEmpty) {
                     return 'Please Enter Link' ;
                   }
                 },),
            const Spacer(flex: 3,),
              FutureBuilder(
                future: user, // Assuming user is your Future<User> variable
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final token = snapshot.data!.token;

                    return widget.checkAdd?SecondaryButtonWidget(
                      onTap:(){
                        postData(token!);
                      },
                      text: 'ADD',

                      width: MediaQuery.of(context).size.width / 2.5,

                    ):SecondaryButtonWidget(onTap: () {
print('id : ${widget.idContainer!}');
                      updateLink(widget.idContainer!, token!, _title.text, _link.text);

                       Navigator.pop(context);

                       showMessage(context, message: 'Updated Successfully');
                    } , text: 'Save');
                  }

                  return const CircularProgressIndicator();
                },
              ),

              const Spacer(flex: 20,),

            ],
          ),
        ),
      ),
    );
  }
}
