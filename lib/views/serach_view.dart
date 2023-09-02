import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/follow_controller.dart';
import 'package:tt9_betweener_challenge/controllers/search_controller.dart';
import 'package:tt9_betweener_challenge/models/follow.dart';
import 'package:tt9_betweener_challenge/models/user.dart';
import 'package:tt9_betweener_challenge/show_mixin.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import 'package:tt9_betweener_challenge/views/widgets/search_container_result_widget.dart';

class SearchView extends StatefulWidget {
  static String id = '/searchView';

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with Helpers {
  Timer? _debounceTimer;
  FocusNode focusNode = FocusNode();
  late Follow follow ;

  @override
  void initState() {
    // TODO: implement initState
     getFollowingFollowers().then((value) {
    follow = value ;
    setState(() { });


     });
    focusNode.requestFocus();
    super.initState();
  }
  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  List<UserClass> listOfUsers = []; // stored data returned from api
  submitSearch(String query){
      _debounceTimer?.cancel(); // Cancel previous timer if any
      if(query.isNotEmpty) {
        _debounceTimer = Timer(const Duration(milliseconds: 100), () {

          Map<String,dynamic> body = {'name':query};
          searchController(body).then((value){
            // value dataType => List<UserClass> .
            // store all results in this list , now go to show data in listView
              listOfUsers = value ;
              setState(() {   });


          });

        });
      } else {
        setState(() {
          listOfUsers.clear();
        });

      }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
         const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 24.0),
            child: CustomTextFormField(
              focusNode: focusNode,
              onChanged: submitSearch ,
                label: 'Search',
              icon: Icons.search,
              hint: 'Enter user name to search',
            ),
          ),
          Expanded(
            child: ListView.builder(

              itemCount: listOfUsers.length,
             itemBuilder: (context, index) {

             return SearchContainerResultWidget(
               name: listOfUsers[index].name!,
               isSearch: true,
             isFollowed: follow.following.where((element){
               return element.id == listOfUsers[index].id! ;
             }).isNotEmpty ? true : false,
              followFunction: (){
                 print('followFunction');
                 addFollow(listOfUsers[index].id!).then((value){
                   print(value);
                   if(value){
                     showMessage(context, message: 'Been followed up ${listOfUsers[index].name}',error: false);
                   }
            // now update list of users
            getFollowingFollowers().then((value) {
             setState(() {
               follow = value ;
             });


            });

                 });
},
               unFollowFunction: (){
                 print('aaaa');
               },
             );
             },

            ),
          ),
        ],
      ),
    );
  }
}
