//import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:self_help/login.dart';
import 'package:self_help/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatelessWidget {

  signOut() async{
    await FirebaseAuth.instance.signOut();
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.remove("email");
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
    //   return MyLogin();
    //}));

  }

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
             decoration: BoxDecoration(
                 color: Colors.green,
                 image: DecorationImage(
                     fit: BoxFit.fill,
                     image: AssetImage('assets/dashsutri.jpeg'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.push(
            context, MaterialPageRoute(
            builder: (context) =>
                ProfilePage()),
            )},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {

              signOut(),
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>MyLogin()))
            },
          ),
        ],
      ),

    );
  }
}