//import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:self_help/login.dart';
import 'package:self_help/otherPages/aboutApp.dart';
import 'package:self_help/otherPages/contactUs.dart';
import 'package:self_help/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatelessWidget {

  signOut() async{
    await SessionManager().destroy();
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
          DrawerHeader( margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
             decoration: BoxDecoration(

              
                 color: Colors.green,
                 image: DecorationImage(
                        
                    fit: BoxFit.fill,
                     image: AssetImage('assets/dashsutri.jpeg'),)),padding: EdgeInsets.fromLTRB(1, 0, 0, 0),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {Navigator.of(context).pop()},
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
            leading: Icon(Icons.adb_sharp),
            title: Text('About App'),
            onTap: () => {Navigator.push(
              context, MaterialPageRoute(
                builder: (context) =>
                    aboutApp()),
            )},
          ),
          ListTile(
            leading: Icon(Icons.account_box_outlined),
            title: Text('Contact Us'),
            onTap: () => {Navigator.push(
              context, MaterialPageRoute(
                builder: (context) =>
                    contactUs()),
            )},
          ),
          // ListTile(
          //   leading: Icon(Icons.border_color),
          //   title: Text('Feedback'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
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