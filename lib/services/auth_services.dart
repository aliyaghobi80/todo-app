import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/screens/home_screen.dart';

class AuthServices {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //Register User
  Future<User?> register({
    required String email,
    required String password,
    required String username,
    required String birthday,
  }) async {
    try {
      User? user =
      (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).user;
      users.add({
        "username": username,
        "email": email,
        "userid": firebaseAuth.currentUser!.uid,
        "birthday": birthday,
      }).then((value) {
        print("User added");
        Get.offNamed(HomeScreen.id);
      }).catchError((onError) {
        Get.snackbar('Error', onError.toString());
      });
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          Get.snackbar('email', "Email already used. Go to login page.",
              snackPosition: SnackPosition.BOTTOM,
              animationDuration: Duration(seconds: 2),
              colorText: Colors.white);
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
           Get.snackbar('password', "Wrong email/password combination.",
              snackPosition: SnackPosition.BOTTOM,
              animationDuration: Duration(seconds: 2),
              colorText: Colors.white);
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
           Get.snackbar('user', "No user found with this email.",
              snackPosition: SnackPosition.BOTTOM,
              animationDuration: Duration(seconds: 2),
              colorText: Colors.white);
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
           Get.snackbar('user', "User disabled.",
              snackPosition: SnackPosition.BOTTOM,
              animationDuration: Duration(seconds: 2),
              colorText: Colors.white);
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
           Get.snackbar(
              'operation', "Too many requests to log into this account.",
              snackPosition: SnackPosition.BOTTOM,
              animationDuration: Duration(seconds: 2),
              colorText: Colors.white);
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
           Get.snackbar(
              'operation', "Server error, please try again later.",
              snackPosition: SnackPosition.BOTTOM,
              animationDuration: Duration(seconds: 2),
              colorText: Colors.white);
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
           Get.snackbar('invalid', "Email address is invalid.",
              snackPosition: SnackPosition.BOTTOM,
              animationDuration: Duration(seconds: 2),
              colorText: Colors.white);
          break;
        default:
           Get.snackbar('invalid', "Login failed. Please try again.",
              snackPosition: SnackPosition.BOTTOM,
              animationDuration: Duration(seconds: 2),
              colorText: Colors.white);
          break;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (firebaseAuth.currentUser == null) {
        print("sign in failed!!");
        Get.snackbar('sign in', 'sign in failed!!',
            snackPosition: SnackPosition.BOTTOM,
            animationDuration: Duration(seconds: 2),
            colorText: Colors.white);
        // Get.toNamed(SignUpScreen.id);
      } else {
        print("user Login..");
        Get.offNamed(HomeScreen.id);
      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('user', 'user-not-found',
            snackPosition: SnackPosition.BOTTOM,
            animationDuration: Duration(seconds: 2),
            colorText: Colors.white);
      } else if (e.code == 'wrong-password') {
        Get.snackbar('wrong', 'wrong-password',
            snackPosition: SnackPosition.BOTTOM,
            animationDuration: Duration(seconds: 2),
            colorText: Colors.white);
      } else if (e.code == 'unknown') {
        Get.snackbar('unknown', 'Please Type more...',
            snackPosition: SnackPosition.BOTTOM,
            animationDuration: Duration(seconds: 2),
            colorText: Colors.white);
      }
    }
    return null;
  }
}
