import 'dart:async';

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
import 'package:self_help/successful_msg.dart';
import 'package:url_launcher/url_launcher.dart';

class showSchemes extends StatefulWidget {
  const showSchemes({Key? key}) : super(key: key);

  @override
  State<showSchemes> createState() => _showSchemesState();
}

class _showSchemesState extends State<showSchemes> {


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
    setState(() {
      
    });
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
              ' Govt Schemes/शासकीय योजना',
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

                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("govSchemes")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          final snap = snapshot.data!.docs;
                          return ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: snap.length,
                            itemBuilder: (context, index) {
                              return Container(

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
                                child: Stack(
                                  children: [
                                    Container(
                                      child:Expanded(child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(left: 20),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '${index+1}',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(

                                            margin:
                                            const EdgeInsets.only(left: 20),width: 230,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              snap[index]['scheme'],
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                            const EdgeInsets.only(left: 20),
                                            alignment: Alignment.centerLeft,
                                            child: IconButton(



                                                onPressed: () async {
                                                  // final Uri url =
                                                  // Uri(scheme: 'https', host: 'www.github.com', path: 'himanshusharma89/');
                                                  //const Uri url = 'https://github.com/himanshusharma89';
                                                  final Uri url = Uri.parse(snap[index]['link']);
                                                  if (!await launchUrl(
                                                    url,
                                                    mode: LaunchMode.externalApplication,
                                                  )) {
                                                    throw 'Could not launch $url';
                                                  }



                                              }, icon: Icon(FontAwesomeIcons.link),color:Colors.lightBlue ,

                                            ),
                                          ),

                                        ],
                                      )),)
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    )
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
