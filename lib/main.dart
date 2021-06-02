import 'package:flutter/material.dart';
import 'package:thrift_books/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      // Replace the 3 second delay with your initialization code:
      future: Future.delayed(Duration(seconds: 6)),  //after three seconds screen will move to next screen
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {  //if its connecting,screen will go to splash screen
          return MaterialApp(home: SplashScreen());   //need to create this screen
        } else {
          // Loading is done, return the app:
          return MaterialApp(
            home: Scaffold(body: Center(child: Text('App loaded'))),
          );
        }
      },
    );
  }
}
