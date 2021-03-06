import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/screens/Login_screen.dart';
import 'package:todo/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static String id = '/SplashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
         return   SafeArea(
              child: Container(
                height: size.height,
                width: size.width,
                color: Theme
                    .of(context)
                    .primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CircleAvatar(
                      radius: 80,
                      child: Text(
                        '< ToDo >',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Spacer(),
                    DefaultTextStyle(

                      style: TextStyle(fontSize: 30,
                          decoration: TextDecoration.none,
                          color: Colors.white),
                      child: AnimatedTextKit(animatedTexts: [
                        FadeAnimatedText('hi!'),
                        TyperAnimatedText(
                            '<<< welcome >>>', speed: Duration(milliseconds: 150,)),
                        RotateAnimatedText('do it RIGHT NOW!!!'),
                      ],
                        repeatForever: false,
                        isRepeatingAnimation: false,
                        onFinished: () {
                            Get.offNamed(HomeScreen.id);
                        },
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AvatarGlow(
                          child: CircularProgressIndicator(), endRadius: 40),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            );
          }//
          else{
         return SafeArea(
           child: Container(
             height: size.height,
             width: size.width,
             color: Theme
                 .of(context)
                 .primaryColor,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 SizedBox(
                   height: 10,
                 ),
                 CircleAvatar(
                   radius: 80,
                   child: Text(
                     '< ToDo >',
                     style: TextStyle(fontSize: 30),
                   ),
                 ),
                 Spacer(),
                 DefaultTextStyle(

                   style: TextStyle(fontSize: 30,
                       decoration: TextDecoration.none,
                       color: Colors.white),
                   child: AnimatedTextKit(animatedTexts: [
                     FadeAnimatedText('hi!'),
                     TyperAnimatedText(
                         '<<< welcome >>>', speed: Duration(milliseconds: 150,)),
                     RotateAnimatedText('do it RIGHT NOW!!!'),
                   ],
                     repeatForever: false,
                     isRepeatingAnimation: false,
                     onFinished: () {
                        Get.offNamed(LoginScreen.id);
                     },
                   ),
                 ),
                 Spacer(),
                 Container(
                   padding: EdgeInsets.all(20),
                   decoration: BoxDecoration(
                     color: Colors.black12,
                     borderRadius: BorderRadius.circular(10),
                   ),
                   child: AvatarGlow(
                       child: CircularProgressIndicator(), endRadius: 40),
                 ),
                 SizedBox(
                   height: 50,
                 ),
               ],
             ),
           ),
         );
          }
        },
      ),
    );
  }
}
