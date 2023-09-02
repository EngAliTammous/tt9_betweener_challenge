import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/constants.dart';


class FollowBtnWidget extends StatelessWidget {
  const FollowBtnWidget({super.key,required this.isFollowed , required this.unFollowFunction , required this.followFunction});

  final bool isFollowed ;
  final Function()? followFunction ;
  final Function()? unFollowFunction ;
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: (){
        followFunction!();
      }  ,


      style: ElevatedButton.styleFrom(
        backgroundColor: kSecondaryColor,
        foregroundColor: kOnSecondaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        )
      ),
      child: Text(isFollowed?'UnFollow':'Follow'),
    );
  }
}
