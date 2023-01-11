import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:self_help/successful_msg.dart';

class aboutApp extends StatefulWidget {
  const aboutApp({Key? key}) : super(key: key);

  @override
  State<aboutApp> createState() => _aboutAppState();
}

class _aboutAppState extends State<aboutApp> {


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
              ' About App/ॲप बद्दल',
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

                      margin:
                      const EdgeInsets.only(left: 20),width:330,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                        """

-बचतगट अ‍ॅप हे बचत गटांचे व्यवहार, हिशोब व सर्व क्रिया व्यवस्थापित करणारे अ‍ॅप आहे.
                        
-बचत गट हा एक सामाजिक-आर्थिक उपक्रम आहे. ही प्रक्रिया संघटितपणे एकमेकांना समजून घेत होत असल्याने या रचनेला स्वयंसाहाय्य गट असेही संबोधले जाते.

-गटाला काहीतरी विशिष्ट नाव ठेवले जाते, उदा.जागृती बचत गट, अस्मिता बचत गट इ. बचत गट म्हणजे ठराविक काळाने बचत जमा करण्याच्या निमित्ताने एकत्र येणारा गट होय.

-बचतगट अ‍ॅपद्वारे बचतगटाचे सर्व व्यवहार पारदर्शकता ठेवण्यात मदत होते.

-हे अ‍ॅप वापरताना आपणास कोणत्याही प्रकारची अडचण आल्यास आमच्याशी संपर्क साधा.
""",
                      ),
                    ),

                  ],
                )),)
            ],
          ),
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
