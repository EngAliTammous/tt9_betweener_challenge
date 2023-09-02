import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/views/widgets/follow_btn_widget.dart';

import '../../constants.dart';



class SearchContainerResultWidget extends StatelessWidget {
  const SearchContainerResultWidget({super.key , required this.name ,required this.isFollowed ,required this.isSearch , this.followFunction , this.unFollowFunction});

  final String name ;
  final bool isSearch ;
  final bool isFollowed ;
  final Function()?followFunction ;
  final Function()? unFollowFunction;
  @override
  Widget build(BuildContext context) {
    return  Container(

     padding: const EdgeInsets.symmetric(horizontal: 12.0 , vertical: 12.0),
      margin:const  EdgeInsets.symmetric(horizontal: 12.0 , vertical: 8.0),
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.all(Radius.circular(12.0))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name,style: const TextStyle(color: kLightSecondaryColor,fontSize: 18.0),),
          isSearch?  FollowBtnWidget(isFollowed: isFollowed, followFunction: followFunction ,unFollowFunction:unFollowFunction ,):const Text(''),
        ],
      ),
    );
  }
}
