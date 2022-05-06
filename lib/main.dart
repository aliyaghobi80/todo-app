import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/screens/Login_screen.dart';
import 'package:todo/screens/home_screen.dart';
import 'package:todo/screens/person_info.dart';
import 'package:todo/screens/sign_up_screen.dart';
import 'package:todo/services/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.lazyPut<AuthServices>(()=>AuthServices());
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: SignUpScreen.id, page:()=> SignUpScreen()),
        GetPage(name: LoginScreen.id, page:()=> LoginScreen()),
        GetPage(name: HomeScreen.id, page:()=> HomeScreen()),
        GetPage(name: PersonInfo.id, page:()=> PersonInfo()),
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      theme: ThemeData.dark(),
      transitionDuration: Duration(seconds: 1),
      defaultTransition: Transition.circularReveal,
    );
  }
}
