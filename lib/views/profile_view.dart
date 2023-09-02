import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/controllers/follow_controller.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/controllers/user_controller.dart';
import 'package:tt9_betweener_challenge/show_mixin.dart';
import 'package:tt9_betweener_challenge/views/add_edit_link_view.dart';
import 'package:tt9_betweener_challenge/views/edit_user_info_view.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_profile_widget.dart';
import 'package:tt9_betweener_challenge/views/widgets/retractable_container_widget.dart';
import 'package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart';

import '../models/follow.dart';
import '../models/link.dart';
import '../models/user.dart';

class ProfileView extends StatefulWidget {
  static String id = '/profileView';

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with Helpers {

  late Future<User> user ;
  late Future<List<Link>> links;
  late Future<Follow> follow ;


  Future updateScreen() async {
    setState(() {
      links = getLinks(context);
    });

  }

  Future<void> _refreshLinks() async {
    await updateScreen();
  }

  @override
  void initState() {
    // TODO: implement initState
    user = getLocalUser();
    links = getLinks(context);
    follow = getFollowingFollowers();

    _refreshLinks();
    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Add this line

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Add this line
     // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Container(),
        title: const Text('Profile',style: TextStyle(fontSize:24 , color: kPrimaryColor ),),
      ),
floatingActionButton: Padding(
  padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height/7,right: 16),
  child:   FloatingActionButton(
      onPressed: (){
       Navigator.push(context, MaterialPageRoute(builder: (context) =>
            AddEditLinkView(checkAdd: true,),
       ),).then((value){
         value == true ? _refreshLinks():const Column();
       });






        setState(() {

          links = getLinks(context);
        });
      },
      elevation: 0,
      child:const Icon(Icons.add,color: kPrimaryColor,size: 32,)),
),
body:  ListView(
  //mainAxisAlignment: MainAxisAlignment.center,
  //crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    FutureBuilder(
      future: user,
      builder: (context, snapshot) {
      if(snapshot.hasData){
        return CustomProfileWidget(
          name: snapshot.data?.user!.name??'',
          email:snapshot.data?.user!.email??'' ,

          onTapEdit: (){
            Navigator.pushNamed(context, EditUserInfoView.id);
          },

        );
      }else if(snapshot.hasError){
        print('error ${snapshot.error}');
       // showMessage(context, message: 'There error',error: true);
      }
      return const CircularProgressIndicator();

    },),
    FutureBuilder(
      future: links,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Column(
            children: [
              Center(child: CircularProgressIndicator()),
              SizedBox(height: 16),
              Text(
                'Make sure internet connection',
                style: TextStyle(color: kOnSecondaryColor, fontSize: 14),
              ),
            ],
          );
        } else if (snapshot.hasData) {

            return SizedBox(
              height: MediaQuery.of(context).size.height/1.7,
              child: ListView.builder(

                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {


                   // print(snapshot.data!.length);
                  return RetractableContainer(
                      checkEven: index%2==0,
                      title:snapshot.data![index].title!.toUpperCase(),
                      link: snapshot.data![index].link!,

                      deleteOnTap: () async{
                        int id = snapshot.data![index].id!;
                      User u = await user;  // Wait for the future to complete
                      if(mounted){
                        showMessage(context, message: 'Wait...');
                      }
                      deleteLink(id, u.token!).then((_) {
                        // Refresh the list of links after successful deletion
                        setState(() {
                          links = getLinks(context);
                        });
                      }).catchError((error) {
                        // Handle error
                        print('Error while deleting link: $error');
                      });

                    },
                    editOnTap: ()async{
                      int id = snapshot.data![index].id!;

                        if(mounted){
                          showMessage(context, message: 'Wait...');
                        }

                        Navigator.push(context, MaterialPageRoute(builder:(context) =>  AddEditLinkView(
                          checkAdd: false,
                          idContainer: id,
                          refreshScreen: (){

                            setState(() {
                              links = getLinks(context);
                            });
                          },
                        ),));
                    },
                  );
                },

              ),
            );

        } else {
          return const Column( mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator()], );
        }
      },
    ),



  ],
),
    );
  }
}

