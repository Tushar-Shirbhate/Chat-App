import 'package:chat_app/Authentication/LoginScreen.dart';
import 'package:chat_app/Screen/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
        if(_auth.currentUser != null){
          return HomeScreen();
        }
        else{
          return LoginScreen();
        }
  }
}
