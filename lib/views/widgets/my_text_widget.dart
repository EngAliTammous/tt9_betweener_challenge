import 'package:flutter/material.dart';


class MyTextWidget extends StatelessWidget {
   MyTextWidget({
    this.color = Colors.white,
    required this.title,
    super.key,
  });
final String title ;
Color? color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Text(title,style:  TextStyle(color: color),),
    );
  }
}
