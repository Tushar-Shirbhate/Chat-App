import 'package:chat_app/Authentication/Methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ChatRoom.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? userMap;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  void onSearch () async{
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection("users")
    .where("email", isEqualTo: _search.text)
    .get()
    .then((value){
      setState(() {
        userMap = value.docs[0].data();
        isLoading =false;
      });
      print(userMap);
    });
  }

  String chatRoomId(String user1, String user2){
    if(user1[0].toLowerCase().codeUnits[0] >
    user2.toLowerCase().codeUnits[0]){
      return "$user1$user2";
    }
    else{
      return "$user2$user1";
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              logOut(context);
            },
            icon: Icon(Icons.logout)
          )
        ],
      ),
      body: isLoading
        ? Center(
        child: CircularProgressIndicator()
      )
      :SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25
            ),
            Container(
              padding: EdgeInsets.all(20),
              height: size.height / 7.5,
              width: size.width,
              alignment: Alignment.center,
              child: TextField(
                controller: _search,
                decoration: InputDecoration(
                  hintText: "Search Email",
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                )
              )
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: onSearch,
                child: Text(
                    "Search",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                ))),
            userMap != null
            ? ListTile(
                onTap: (){
                  String roomId = chatRoomId(
                    _auth.currentUser!.displayName!,
                    userMap!['name']
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatRoom(
                          chatRoomId: roomId,
                      userMap: userMap!)
                    )
                  );
                },
              leading: Icon(Icons.account_box, color:Colors.black),
              title: Text(
                userMap!['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black
                )
              ),
              subtitle: Text(
                userMap!['email']
              ),
              trailing: Icon(Icons.chat, color: Colors.black,)
            )
                :Container()
          ]
        ),
      )
    );
  }
}
