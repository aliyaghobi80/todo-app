import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/constant.dart';
import 'package:todo/screens/home_screen.dart';
import 'package:todo/screens/sign_up_screen.dart';
import 'package:todo/services/auth_services.dart';
import 'package:todo/widgets/custom_button.dart';
import 'package:todo/widgets/custom_text.dart';

class LoginScreen extends StatefulWidget {
  static String id = '/LoginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final authServices=Get.find<AuthServices>();
  var currentStatus='Not Login';

@override
  void initState() {
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
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
                margin: EdgeInsets.symmetric(horizontal: 10),
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
                                frameRate: FrameRate(30)),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                CustomText(text: 'Login'),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 5),
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      icon: Icon(
                                        Icons.email_outlined,
                                        size: 30,
                                      ),
                                    ),
                                    controller: emailController,
                                    textInputAction: TextInputAction.next,
                                    validator: validateEmail,
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  TextFormField(
                                    validator: validatePassword,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      icon: Icon(
                                        Icons.lock_outline,
                                        size: 30,
                                      ),
                                    ),
                                    controller: passwordController,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomButton(
                                    text: 'Login',
                                    size: size,
                                    onTapped: () {
                                      //complete later
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        print('Form Submit');
                                      }
                                      authServices.login(emailController.text, passwordController.text, context);
                                    },
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.toNamed(SignUpScreen.id);
                                      },
                                      child: Text(
                                        'Dont have an account?',
                                        style: kAccountTextStyle,
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Get.toNamed(HomeScreen.id);
                                      },
                                      child: Text(
                                        'Continue as guest',
                                        style: kAccountTextStyle,
                                      )),
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
      ),
    );
  }

}
