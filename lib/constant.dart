
import 'package:flutter/material.dart';

const kButtonTextStyle=TextStyle(fontSize: 25,fontWeight: FontWeight.w300);
const kAccountTextStyle=TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 15
);

const decorationTextFromField=InputDecoration(hintStyle: TextStyle(fontSize: 18, color: Colors.white54),);


String? validateUsername(String? value){
  if(value!.isEmpty){
    return 'Please Enter Text';
  }
  if(value.length<3){
    return 'Type More...';
  }
  else{
    return null;
  }

}
//below line for handle exception firebase

// String getMessageFromErrorCode() {
//   switch (this.errorCode) {
//     case "ERROR_EMAIL_ALREADY_IN_USE":
//     case "account-exists-with-different-credential":
//     case "email-already-in-use":
//       return "Email already used. Go to login page.";
//       break;
//     case "ERROR_WRONG_PASSWORD":
//     case "wrong-password":
//       return "Wrong email/password combination.";
//       break;
//     case "ERROR_USER_NOT_FOUND":
//     case "user-not-found":
//       return "No user found with this email.";
//       break;
//     case "ERROR_USER_DISABLED":
//     case "user-disabled":
//       return "User disabled.";
//       break;
//     case "ERROR_TOO_MANY_REQUESTS":
//     case "operation-not-allowed":
//       return "Too many requests to log into this account.";
//       break;
//     case "ERROR_OPERATION_NOT_ALLOWED":
//     case "operation-not-allowed":
//       return "Server error, please try again later.";
//       break;
//     case "ERROR_INVALID_EMAIL":
//     case "invalid-email":
//       return "Email address is invalid.";
//       break;
//     default:
//       return "Login failed. Please try again.";
//       break;
//   }
// }
String? validateEmail(String? value) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return 'Enter a valid email address';
  } else {
    return null;
  }
}

String? validatePassword(String? value) {

  if (value == null || value.isEmpty ) {
    return 'Enter Password';
  }
  else if(value.length<6) {
    return 'Invalid password, length must be more than 6';
  }
  return null;
}

// String? validatePassword(String? value) {
//   String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
//   RegExp regExp =  RegExp(pattern);
//   if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
//     return 'Enter a Strong Password';
//   } else {
//     return null;
//   }
// }



