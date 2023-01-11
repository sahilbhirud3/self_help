import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailto/mailto.dart';
import 'package:self_help/successful_msg.dart';
import 'package:url_launcher/url_launcher.dart';

class contactUs extends StatefulWidget {
  const contactUs({Key? key}) : super(key: key);

  @override
  State<contactUs> createState() => _contactUsState();
}

class _contactUsState extends State<contactUs> {
  @override
  void initState() {
    super.initState();
    _getId();
  }

  final db = FirebaseFirestore.instance;
  String r_name = "";
  String id = "";

  Future _getId() async {
    id = await SessionManager().get("bId");
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();
  StreamSubscription<DocumentSnapshot>? subscription;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Contact Us/संपर्क साधा',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )
          ]),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                      width: 330,
                      alignment: Alignment.center,
                      child: Text(
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        "- Institute -\n",
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      width: 330,
                      alignment: Alignment.center,
                      child: Text(
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                        "K.R.T. Arts, B.H. Commerce and A.M. Science College,Ganagapur Road Nashik.422002\n",
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      width: 330,
                      alignment: Alignment.center,
                      child: Text(
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        "- Developed By -\n",
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(2, 2),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  width: 180,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Bhirud Sahil Chudaman',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 3),
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    onPressed: () async {
                                      final call =
                                          Uri.parse('tel:+91 8600386608');
                                      if (!await launchUrl(call)) {
                                        throw 'Could not launch ';
                                      }
                                    },
                                    icon: Icon(FontAwesomeIcons.phone),
                                    color: Colors.lightBlue,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 3),
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    onPressed: () async {
                                      var email = 'sahilbhirud3@gmail.com';
                                      var subject = 'Regarding SHG App';
                                      final Uri mail = Uri.parse(
                                          "mailto:$email?subject=$subject");

                                      if (!await launchUrl(
                                        mail,
                                        mode: LaunchMode.externalApplication,
                                      )) {
                                        throw 'Could not launch ';
                                      }
                                    },
                                    icon: Icon(FontAwesomeIcons.envelope),
                                    color: Colors.redAccent,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 3),
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    onPressed: () async {
                                      final Uri url = Uri.parse(
                                          'https://instagram.com/sahil.bhirud__sb?igshid=MDM4ZDc5MmU=');
                                      if (!await launchUrl(
                                        url,
                                        mode: LaunchMode.externalApplication,
                                      )) {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    icon: Icon(FontAwesomeIcons.instagram),
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                              ],
                            )),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(2, 2),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  width: 190,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Bhavar Chaitanya Sitaram',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 3),
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    onPressed: () async {
                                      final call =
                                          Uri.parse('tel:+91 9579213171');
                                      if (!await launchUrl(call)) {
                                        throw 'Could not launch ';
                                      }
                                    },
                                    icon: Icon(FontAwesomeIcons.phone),
                                    color: Colors.lightBlue,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 2),
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    onPressed: () async {
                                      var email =
                                          'chaitanyabhavar2021@gmail.com';
                                      var subject = 'Regarding SHG App';
                                      final Uri mail = Uri.parse(
                                          "mailto:$email?subject=$subject");

                                      if (!await launchUrl(
                                        mail,
                                        mode: LaunchMode.externalApplication,
                                      )) {
                                        throw 'Could not launch ';
                                      }
                                    },
                                    icon: Icon(FontAwesomeIcons.envelope),
                                    color: Colors.redAccent,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 2),
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    onPressed: () async {
                                      final Uri url = Uri.parse(
                                          'https://www.instagram.com/chaitanya_s_bhavar96k/');
                                      if (!await launchUrl(
                                        url,
                                        mode: LaunchMode.externalApplication,
                                      )) {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    icon: Icon(FontAwesomeIcons.instagram),
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                              ],
                            )),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                      width: 330,
                      alignment: Alignment.center,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText('We would love to help...',
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                              speed: Duration(milliseconds: 200)),
                          WavyAnimatedText(
                            'At your Service...',
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                            speed: Duration(milliseconds: 200),
                          ),
                        ],
                        repeatForever: true,
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
