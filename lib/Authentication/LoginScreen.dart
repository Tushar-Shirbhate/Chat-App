import 'package:chat_app/Authentication/SignUp.dart';
import 'package:chat_app/Screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Methods.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
        body: isLoading
            ? Center(
          child: Container(child: CircularProgressIndicator())
        )
            :SingleChildScrollView(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              SizedBox(
                height: 160
              ),
              Container(
                  child: Text(
                    "Flash Chat",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 44
                    )
                  ),
              ),
              SizedBox(
                height: 50
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller:_email,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                ),
                  hintText: "Enter Email",
                  labelText: "Email"
                )
              ),
              SizedBox(
                height: 20
              ),
              TextField(
                controller: _password,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key_rounded),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                  ),
                  hintText: "Enter Password",
                  labelText: "Password"
                )
              ),
              SizedBox(
                height: 25
              ),
              GestureDetector(
                onTap: (){
                  if(_email.text.isNotEmpty && _password.text.isNotEmpty){
                     setState(() {
                       isLoading = true;
                     });

                     logIn(_email.text, _password.text).then((user){
                       if(user != null){
                         setState(() {
                           isLoading = false;
                         });
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (_) => HomeScreen())
                         );
                       }
                       else{
                         setState(() {
                           isLoading = false;
                         });
                       }
                     });
                  } else{
                    print("please fill the form correctly");
                  }
                },
                child: Container(
                  height: size.height / 14,
                  width: size.width / 3.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "LogIn",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    )
                  )
                )
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUpScreen()));
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "SignUp",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold
                    )
                  )
                )
              ),

            ]
          ),
        )
    );
  }
}
