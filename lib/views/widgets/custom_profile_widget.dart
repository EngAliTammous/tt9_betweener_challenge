import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/show_mixin.dart';
import 'package:tt9_betweener_challenge/views/follow_view.dart';

import '../../constants.dart';
import '../../controllers/follow_controller.dart';
import '../../models/follow.dart';
import 'my_text_widget.dart';

class CustomProfileWidget extends StatefulWidget {
  const CustomProfileWidget({
    required this.email ,
    required this.name,
    required this.onTapEdit,
    this.onPressFollowers ,
    this.onPressFollowing,
    super.key,
  });
final String name ;
final String email ;
final Function() onTapEdit ;
final Function()? onPressFollowers ;
  final Function()? onPressFollowing ;

  @override
  State<CustomProfileWidget> createState() => _CustomProfileWidgetState();
}

class _CustomProfileWidgetState extends State<CustomProfileWidget> with Helpers{
  late Future<Follow> follow ;
@override
  void initState() {
    // TODO: implement initState
  follow = getFollowingFollowers();

  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 16.0),

      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),

      ),
      child: Stack(
        children:[
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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

            Padding(
               padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextWidget(title: widget.name,),
              MyTextWidget(title: widget.email),
              MyTextWidget(title: '+972598891656')  ,
                  const SizedBox(height: 12.0,),
                  FutureBuilder(
                    future: follow, // Replace with your common future
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Row(
                          children: [
                            FollowersContainerWidget(
                              title: 'Followers',
                              followersCount: 0,
                              onTap: () {
                                // Handle followers tap
                              },
                            ),
                            const SizedBox(width: 8),
                            FollowersContainerWidget(
                              title: 'Following',
                              followersCount: 0,
                              onTap: () {
                                // Handle following tap
                              },
                            ),
                          ],
                        );
                      }
                      else if (snapshot.hasError) {
                        print(snapshot.data);
                        print('error : ${snapshot.error}');
                        return const Text('check internet');
                      } else if (snapshot.hasData) {

                        if (snapshot.data != null) {

                          return Row(
                            children: [
                              FollowersContainerWidget(
                                title: 'Followers',
                                followersCount: snapshot.data!.followersCount,
                                onTap: () {
                                  // Handle followers tap
                                  if(snapshot.data!.followers.isNotEmpty){
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          FollowView(title: 'Followers',follow: snapshot.data!.followers),),);

                                  }else {
                                    showMessage(context, message: 'Followers 0',error: false);
                                  }

                                },
                              ),
                              const SizedBox(width: 8),
                              FollowersContainerWidget(
                                title: 'Following',
                                followersCount: snapshot.data!.followingCount,
                                onTap: () {
                                  // Handle following tap
                                  if(snapshot.data!.following.isNotEmpty){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  FollowView(title: 'Following',follow: snapshot.data!.following),));

                                  }else {
                                    showMessage(context, message: 'Following 0',error: false);
                                  }
                                },
                              ),
                            ],
                          );
                        }  else {
                          return Row(
                            children: [
                              FollowersContainerWidget(
                                title: 'Followers',
                                followersCount: 0,
                                onTap: () {
                                  // Handle followers tap
                                },
                              ),
                              const SizedBox(width: 8),
                              FollowersContainerWidget(
                                title: 'Following',
                                followersCount: 0,
                                onTap: () {
                                  // Handle following tap
                                },
                              ),
                            ],
                          );
                        }

                      }
                      return SizedBox();
                    }

    ),

                ],
              ),
            ),
          ],
        ),
          Positioned(
              right: 2,
bottom: 80,
              child: IconButton(onPressed: widget.onTapEdit, icon:const Icon(Icons.edit,color: Colors.white,)))

        ],
      ),
    );
  }
}

class FollowersContainerWidget extends StatelessWidget {
  const FollowersContainerWidget({
    required this.followersCount,
    required this.title ,
    required this.onTap,
    super.key,
  });

  final int followersCount ;
final String title ;
final Function() onTap ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //margin: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 4.0),
        width: MediaQuery.of(context).size.width/4,
        height: MediaQuery.of(context).size.height/30,
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(child: MyTextWidget(title: '$title ${followersCount}',color: kPrimaryColor,)),

      ),
    );
  }
}

