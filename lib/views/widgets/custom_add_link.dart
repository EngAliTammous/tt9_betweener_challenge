

import 'package:flutter/material.dart';

import '../../constants.dart';
import '../add_edit_link_view.dart';

class CustomAddLinkWidget extends StatefulWidget {
  const CustomAddLinkWidget({super.key , required this.onTap});

  final Function() onTap ;
  @override
  State<CustomAddLinkWidget> createState() => _CustomAddLinkWidgetState();
}

class _CustomAddLinkWidgetState extends State<CustomAddLinkWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width/3,

        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
        decoration: BoxDecoration(
            color: kHomeAddLinkColor,
            borderRadius: BorderRadius.circular(15)),
        child: const Column(
          children: [
            Icon(Icons.add,size: 28,),
            SizedBox(height: 8,),
            Text('Add link',style: TextStyle(fontSize: 18,color:kPrimaryColor )),
          ],
        ),
      ),

    );
  }
}
