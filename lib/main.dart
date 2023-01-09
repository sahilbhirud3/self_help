//import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:self_help/login.dart';
import 'package:self_help/register.dart';
import 'package:self_help/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:self_help/successful_msg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_help/share.dart';
// ...
var id;
Future _getId() async {
  id=await SessionManager().get("bId");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs =await SharedPreferences.getInstance();
  String? email=prefs.getString("email");

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context) => MyLogin(),
      'register': (context) => MyRegister(),
      'successful_msg': (context) => MySuc(),
      'dashboard': (context) => MyDash(bID:id),
    },
  ));
}
