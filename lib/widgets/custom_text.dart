import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {

final String text;
CustomText({required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(
      decoration: TextDecoration.none, fontSize: 40, color: Colors.white,),
      textAlign: TextAlign.start,);
  }
}
