
import 'package:flutter/material.dart';
import 'package:todo/constant.dart';

class CustomButton extends StatelessWidget {
  Size size;
  VoidCallback onTapped;
CustomButton({Key? key,required this.size,required this.onTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Material(
      borderRadius: BorderRadius.circular(50),
      color: Colors.transparent,
      elevation: 2,
      shadowColor: Colors.redAccent.shade200,
      child: InkWell(
        onTap:onTapped ,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          height: 50,
          width: size.width * 0.7,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: const[Colors.white12, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: const [
              SizedBox(
                width: 10,
              ),
              Spacer(),
              Text(
                'Sign Up',
                style: kButtonTextStyle,
              ),
              Spacer(),
              Icon(Icons.arrow_forward),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
