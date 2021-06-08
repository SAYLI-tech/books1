import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thrift_books/screens/login_screen.dart';

import 'location_screen.dart';

class SplashScreen extends StatefulWidget {

  static const String id = 'splash-screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){

    Timer(
      Duration(
        seconds: 3,

      ),() { //Duration
      FirebaseAuth.instance.authStateChanges().listen((User user) {
        if (user == null) {
          // not signed in
          Navigator.pushReplacementNamed(context, LoginScreen.id);
        } else {
          //if user has data in firestore check delivery address set or not
          // signed in
          Navigator.pushReplacementNamed(context, LocationScreen.id);
        }
      }
      );
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    const colorizeColors = [
      Colors.white,
      Colors.cyan,

    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 30.0,
      fontFamily: 'Lato',
    );



    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.cyan.shade900,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png',
              color: Colors.white,
            ),
            SizedBox(height: 10,),
            //need an animated text
        AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'Thrift Books',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),

          ],
          isRepeatingAnimation: true,
          onTap: () {
            print("Tap Event");

          },
        ),
          ],
        ),
      ),
    );
  }
}

//will design splash screen now