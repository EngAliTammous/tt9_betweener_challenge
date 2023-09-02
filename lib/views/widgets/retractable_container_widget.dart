import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../constants.dart';

class RetractableContainer extends StatelessWidget {
  const RetractableContainer({super.key ,
    required this.editOnTap ,
    required this.deleteOnTap ,
    required this.checkEven,required this.title , required this.link});

 final bool checkEven  ;
final String title ;
final String link ;
final Function() editOnTap ;
final Function() deleteOnTap ;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0,),
      margin:const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),

      child: Slidable(
        endActionPane:  ActionPane(
          extentRatio: 0.6,
          motion: const ScrollMotion(),
          children:  [
            SlidableAction(
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              onPressed: (context) => editOnTap(),
              backgroundColor: kSecondaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
            ),
            const SizedBox(width: 12.0,),
            SlidableAction(
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              onPressed: (context) => deleteOnTap(),
              backgroundColor: kDangerColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
             // padding: const EdgeInsets.all(0),
            ),
            const SizedBox(width: 8.0,),
          ],
        ),

        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            color: checkEven ? kProfileConColor : kLightPrimaryColor,
          ),
          child: ListTile(
            subtitle: Text(
             link,
              style: TextStyle(
                color: checkEven ? kEvenColor : kLinksColor,
                fontSize: 14,
              ),
            ),
            title: Text(
             title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: checkEven ? kOnLightDangerColor : kPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

}