import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:thrift_books/screens/authentication/email_auth_screen.dart';
import 'package:thrift_books/screens/authentication/email_verification_screen.dart';
import 'package:thrift_books/screens/authentication/google_auth.dart';
import 'package:thrift_books/screens/authentication/phoneauthscreen.dart';
import 'package:thrift_books/services/phoneauth_service.dart';
import '../screens/authentication/google_auth.dart';




class AuthUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width:220,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(3.0),
                ),
                ),


                onPressed: ()
                {
                  //now u can easily navigate to phone auth screen
                  Navigator.pushNamed(context, PhoneAuthScreen.id);

                }, child: Row(
                children: [
                Icon(Icons.phone_android_outlined,color: Colors.black,),
                SizedBox(width: 8,),
                Text('Continue with Phone',style: TextStyle(color: Colors.black),),
              ],
            )),
          ),
          SignInButton(
            Buttons.Google,
            text: ('Continue with Google'),
            onPressed: () async{

              User user = await GoogleAuthentication.signInWithGoogle(context: context);
              if(user!=null){
                //login success

                PhoneAuthService _authentication = PhoneAuthService();
                _authentication.addUser(context, user.uid);
              }

            },
          ),
          SignInButton(
            Buttons.FacebookNew,
            text: ('Continue with Facebook'),
            onPressed: (){},
          ),

          // if you want to add onPressed to container
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, EmailAuthScreen.id);
              //before add new user , lets design verification screen

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  'Login with email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,

                  ),
                ),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white))
                )
              ),
            ),
          )


        ],
      ),
    );
  }

}