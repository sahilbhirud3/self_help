//import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:self_help/login.dart';
import 'package:self_help/register.dart';
import 'package:self_help/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:self_help/successful_msg.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context) => MyLogin(),
      'register': (context) => MyRegister(),
      'successful_msg': (context) => MySuc(),
      //'dashboard': (context) => MyDash(),
    },
  ));
}
