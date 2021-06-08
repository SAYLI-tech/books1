

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thrift_books/screens/authentication/otp_screen.dart';
import 'package:thrift_books/screens/location_screen.dart';

class PhoneAuthService{
  FirebaseAuth auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  
  Future<void> addUser(context, [String uid]) async{
    //call the users collectionReference to add a new user

  final QuerySnapshot result = await users.where('uid',isEqualTo: user.uid).get();


  List<DocumentSnapshot> document = result.docs; //list of user data


  if(document.length>0){
    //user data exists
    //add user data to firestore
    Navigator.pushReplacementNamed(context,LocationScreen.id);
  }
  else {
    //user data does not exsits
    return users.doc(user.uid)
        .set({
      'uid' : user.uid, //user id
      'mobile': user.phoneNumber,
      'email':user.email
    })
        .then((value){
      //after add data to firebase then will go to next screen
      //if you pushreplacementName or push replacement , then you cant go back to previous screen
      Navigator.pushReplacementNamed(context, LocationScreen.id);
    })
        .catchError((error)=> print("Failed to add user: $error"));

  }

  }



  Future<void>verifyPhoneNumber(BuildContext context,number)async{
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential)async{
      await auth.signInWithCredential(credential); //after verification completed ned to signin
    };

    final PhoneVerificationFailed verificationFailed = (FirebaseAuthException e){
      //If verification failed, it will show the reason
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
      print('The error is ${e.code}');
    };
    final PhoneCodeSent codeSent = (String verId, int resendToken)async{
      //if otp send now new screen to should open to enter otp.
      //so we will design a screen now
      Navigator.push(
        context, MaterialPageRoute(builder: (context)=>OTPScreen(number: number,verId:verId),),);

    };

    try{
      auth.verifyPhoneNumber(phoneNumber: number,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed, codeSent: codeSent,
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (String verificationId){
            print(verificationId); //will work on this later
          });
    }catch(e){
      print('Error ${e.toString()}');
    }



  }
}