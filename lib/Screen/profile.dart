import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mafinal/main.dart';

import '../Auth/auth_service.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(''),
        actions: [
          IconButton(
            onPressed: () {
         FirebaseAuth.instance.signOut();
            // signOut();
             Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp()));
            }, 
            icon: Icon(Icons.logout,color: Colors.white,))
        ],
      ),
      body : Center(
        child:  kkk() ? Column(children: [
          Image.network('http://handong.edu/site/handong/res/img/logo.png'),
           Text(FirebaseAuth.instance.currentUser!.uid,style: TextStyle(color: Colors.white),),
            Text('email : Anonymous',style: TextStyle(color: Colors.white)),
            Text('I promise to take the test honestly before GOD',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
        ]) : Column(children: [
           Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
          Text(FirebaseAuth.instance.currentUser!.uid,style: TextStyle(color: Colors.white),),       
          Divider(color: Colors.white),
          Container(
            child: 
              Column(children: [
                Text(FirebaseAuth.instance.currentUser!.email!,style: TextStyle(color: Colors.white),),
                Text(FirebaseAuth.instance.currentUser!.displayName!,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                Text('I promise to take the test honestly before GOD',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)

              ],)
          )
        ],)
      ),
    );
  }
   kkk() {
    bool dfk;
    if(FirebaseAuth.instance.currentUser!.photoURL ==null){
      dfk = true;
    } else {
      dfk= false;
    }
    return dfk;
  }
}