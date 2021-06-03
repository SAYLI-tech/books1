import 'package:flutter/material.dart';
import 'package:thrift_books/widgets/auth_ui.dart';

class LoginScreen extends StatelessWidget {
  static const String id="login-screen";//this also a string
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.cyan.shade900,
      body: Center(
        child: Column(
          children: [
            Expanded(child: Container(
              width: MediaQuery.of(context).size.width,  //to get device width
              color: Colors.white,

              child: ListView(
                children: [
                  SizedBox(height: 100,),
                  Image.asset('assets/images/login.jpg',
                    color: Colors.cyan.shade900,
                  ),
                  SizedBox(height: 10,),
                  Text('Thrift Books',style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan.shade900
                  ),)
                ],
              ),
            ),),
            Expanded(child: Container(
            child: AuthUi(),

            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'If you continue, you are accepting\nTerms and Conditions and Privacy Policy',
                  textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize:10 ),

              ),
            ),
          ],
        ),
      )

    );
  }
}