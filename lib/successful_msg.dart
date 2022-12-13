
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

class MySuc extends StatefulWidget {
  const MySuc({Key? key}) : super(key: key);

  @override
  State<MySuc> createState() => _MySucState();
}

class _MySucState extends State<MySuc> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/succ_login.png'), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset('assets/anilogo.gif'),
                Text(
                  'Registration Successfull/\n         नोंदणी यशस्वी झाली\n',
                  style: GoogleFonts.acme(
                    color: Color.fromRGBO(58, 67, 77, 1.0),
                    fontSize: 33,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Sign In/लॉगिन',
                      style: TextStyle(
                          color: Color(0xff4c505b),
                          fontSize: 27,
                          fontWeight: FontWeight.w700),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xff4c505b),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyLogin()),
                          );
                        },
                        icon: Icon(Icons.arrow_forward),
                      ),
                    )
                  ],
                ),
              ]),
            ])));
  }
}
