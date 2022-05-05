import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/constant.dart';
import 'package:todo/screens/Login_screen.dart';
import 'package:todo/screens/home_screen.dart';
import 'package:todo/services/auth_services.dart';
import 'package:todo/widgets/custom_button.dart';
import 'package:todo/widgets/custom_text.dart';

class SignUpScreen extends StatefulWidget {
  static String id = '/SignUpScreen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController showDateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var currentStatus = 'Not Login';

  final authServices = Get.find<AuthServices>();



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
                                CustomText(text: 'SignUp'),
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
                                    decoration: InputDecoration(
                                      hintText: 'Username',
                                      icon: Icon(
                                        Icons.person_outline_rounded,
                                        size: 30,
                                      ),
                                    ),
                                    controller: usernameController,
                                    textInputAction: TextInputAction.next,
                                    validator: validateUsername,
                                  ),
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
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    decoration:
                                        decorationTextFromField.copyWith(
                                      hintText: 'Enter Your BirthDay',
                                      icon: Icon(
                                        Icons.date_range,
                                        size: 30,
                                      ),
                                    ),
                                    controller: showDateController,
                                    onTap: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(1970, 1, 1),
                                          maxTime: DateTime(2030, 1, 12),
                                          onChanged: (date) {
                                        print('change $date');
                                      }, onConfirm: (date) {
                                        showDateController.text =
                                            date.toString().substring(0, 10);
                                      }, locale: LocaleType.fa);
                                    },
                                    readOnly: true,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomButton(
                                    text: 'Sign Up',
                                    size: size,
                                    onTapped: () {
                                      //complete later
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        print('Form Submit');
                                      }
                                      authServices.register(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        username: usernameController.text,
                                        birthday: showDateController.text,
                                      );
                                    },
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.toNamed(LoginScreen.id);
                                      },
                                      child: const Text(
                                        'Do you have an account?',
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

  void checkUser() {
    User? user = _auth.currentUser;
    if (user == null) {
      print('not Login');
      setState(() {
        currentStatus = 'Not Login';
      });
    } else {
      print('user:${user.uid}');
      setState(() {
        currentStatus = user.email!;
      });
    }
  }

  // void registerUser({var mail, var pass}) async {
  //   final User? user = (await _auth.createUserWithEmailAndPassword(
  //           email: mail, password: pass))
  //       .user;
  //
  //   if (user == null) {
  //     print("sign up failed!!");
  //   } else {
  //     print("user created..");
  //     adduser(mail, usernameController.text, showDateController.text,
  //         _auth.currentUser!.uid);
  //   }
  // }

  // void adduser(var mail, var username, var birthday, var uid) async {
  //   return users.add({
  //     "username": username,
  //     "email": mail,
  //     "userid": uid,
  //     "birthday": birthday,
  //   }).then((value) {
  //     print("User added");
  //     Get.offNamed(HomeScreen.id);
  //   }).catchError((onError) {
  //     Get.snackbar('Error', onError.toString());
  //   });
  // }
}
