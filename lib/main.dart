
//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:self_help/login.dart';
import 'package:self_help/register.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner:false ,
    initialRoute: 'login',
    routes: {
      'login':(context)=>MyLogin(),
      'register':(context)=>MyRegister()
    },
  ));
}
