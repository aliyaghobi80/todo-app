import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/widgets/custom_button.dart';
import 'package:todo/widgets/custom_text.dart';
import 'package:todo/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  static String id = '/SignUpScreen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/background2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Lottie.asset('assets/images/signup.json',
                              height: 250,
                              width: 250,
                              frameRate: FrameRate(60)),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              CustomText(text: 'SignUp'),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  hintText: 'Username',
                                  icon: Icon(
                                    Icons.person_outline_rounded,
                                    size: 30,
                                  ),
                                  textEditingController: usernameController,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomTextField(
                                  hintText: 'Email',
                                  icon: Icon(
                                    Icons.email_outlined,
                                    size: 30,
                                  ),
                                  textEditingController: emailController,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomTextField(
                                  hintText: 'Password',
                                  icon: Icon(
                                    Icons.lock_outline,
                                    size: 30,
                                  ),
                                  textEditingController: passwordController,
                                ),

                                SizedBox(
                                  height: 20,
                                ),
                                CustomButton(
                                  size: size,
                                  onTapped: () {
                                   //complete later
                                  },
                                )
                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
