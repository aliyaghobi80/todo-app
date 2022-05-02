import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final TextEditingController textEditingController;

  CustomTextField(
      {
        Key? key, required this.hintText,
        required this.icon,
        required this.textEditingController,

      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 18, color: Colors.white54),
          prefixIcon: icon
      ),
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    );
  }
}
