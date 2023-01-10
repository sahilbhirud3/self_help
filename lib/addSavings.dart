import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:self_help/successful_msg.dart';

class addSavings extends StatefulWidget {
  const addSavings({Key? key}) : super(key: key);

  @override
  State<addSavings> createState() => _addSavingsState();
}

class _addSavingsState extends State<addSavings> {
  // final CollectionReference _register=
  // FirebaseFirestore.instance.collection('register');
  TextEditingController dateinput = TextEditingController();
  TextEditingController amt1 = TextEditingController();

  //text editing controller for text field

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
    _getId();
  }

  final db = FirebaseFirestore.instance;
  late String reg_no;

//Future<String> id = await SessionManager().get("key");
  String nom_name = "",
      address = "",
      desg = "",
      bankname = "",
      bankac = "",
      pan = "",
      deposit = "",
      mob = "",
      email = "",
      password = "";
  String id = "";
  int amt = 0, fine = 0;

  Future _getId() async {
    id = await SessionManager().get("bId");
    setState(() {});
  }

// id=SessionManager().get("bId");

  final _formKey = GlobalKey<FormState>();
  var status;
  StreamSubscription<DocumentSnapshot>? subscription;

  //final DocumentReference documentReference=FirebaseFirestore.instance.doc("register");
  DateTime? date;

  var mName;

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
              'Add Savings/बचत जमा करा',
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
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              new StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('bachatgat')
                                      .doc(id)
                                      .collection('users')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData)
                                      return const Center(
                                        child:
                                            const CupertinoActivityIndicator(),
                                      );
                                    var length = snapshot.data!.docs.length;
                                    DocumentSnapshot ds =
                                        snapshot.data!.docs[length - 1];
                                    var _queryCat = snapshot.data!.docs;
                                    return new Container(
                                      padding: EdgeInsets.only(bottom: 16.0),
                                      //width: screenSize.width*0.9,
                                      child: new Row(
                                        children: <Widget>[
                                          new Expanded(
                                              flex: 2,
                                              child: new Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    12.0, 10.0, 10.0, 10.0),
                                                child: new Text(
                                                    "Choose Member/सदस्य निवडा",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white)),
                                              )),
                                          new Expanded(
                                            flex: 4,
                                            child: new InputDecorator(
                                              decoration: const InputDecoration(
                                                //labelText: 'Activity',
                                                hintText: 'Choose/निवडा',
                                                hintStyle: TextStyle(
                                                  //color: primaryColor,
                                                  fontSize: 12.0,
                                                  color: Colors.white,
                                                  fontFamily: "OpenSans",
                                                  //fontWeight: FontWeight.normal,
                                                ),
                                              ),

                                              //style: TextStyle(color: Colors.white),
                                              isEmpty: mName == null,
                                              child:
                                                  new DropdownButtonFormField(
                                                //dropdownColor: Colors.greenAccent,
                                                //selectedItemBuilder: ,
                                                //style: TextStyle(color: Colors.white),

                                                value: mName,
                                                isDense: true,

                                                //iconSize: 0.0,
                                                isExpanded: true,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    mName = newValue;

                                                    //dropDown = false;
                                                    print(mName);
                                                  });
                                                },

                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Select Member';
                                                  }
                                                  return null;
                                                },
                                                itemHeight: null,
                                                items: snapshot.data!.docs.map(
                                                    (DocumentSnapshot
                                                        document) {
                                                  return new DropdownMenuItem<
                                                          String>(
                                                      value:
                                                          document.get('name'),
                                                      child: new Container(
                                                        // decoration: new BoxDecoration(
                                                        //    color: Colors.white,
                                                        //     borderRadius: new BorderRadius.circular(5)
                                                        // ),
                                                        color: Colors.white,
                                                        height: 20.0,

                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                10.0,
                                                                2.0,
                                                                10.0,
                                                                0.0),

                                                        child: new Text(
                                                          document.get('name'),
                                                        ),
                                                      ));
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                              TextFormField(
                                textAlignVertical: TextAlignVertical.top,
                                style: TextStyle(
                                  color: Colors.white,
                                  height: 0.3,
                                ),
                                controller: dateinput,

                                //editing controller of this TextField
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    icon: Icon(Icons.calendar_today,
                                        color: Colors.white),
                                    labelText: "Date/ तारीख",
                                    labelStyle: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                readOnly: true,
                                //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2018),
                                      //- not to allow to choose before today.
                                      lastDate: DateTime.now());

                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('dd-MM-yyyy')
                                            .format(pickedDate);
                                    date =
                                        pickedDate; //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                    setState(() {
                                      dateinput.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                    // FirebaseFirestore.instance
                                    //     .collection('bachatgat')
                                    //     .doc(id)
                                    //     .collection('users')
                                    //     .where('name',isEqualTo: mName)
                                    //     .get().then((value) =>
                                    //     FirebaseFirestore.instance
                                    //         .collection('bachatgat')
                                    //         .doc(id)
                                    //         .collection('users')
                                    //         .doc(value.docs.first.id).collection('savings')
                                    //         .where('date',isEqualTo:DateTime(date.year,date.month))
                                    // );
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Entry Date/प्रवेशाची तारीख प्रविष्ट करा';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                style:
                                    TextStyle(color: Colors.white, height: 0.3),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Saving Amount/बचत रक्कम",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onChanged: (String val) {
                                  amt = int.parse(val);
                                  print(amt);
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Saving Amount/बचत रक्कम प्रविष्ट करा';
                                  }
                                  return null;
                                },
                                controller: amt1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                style:
                                    TextStyle(color: Colors.white, height: 0.3),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Fine/दंड",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onChanged: (_val) {
                                  fine = int.parse(_val);
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Fine/दंड प्रविष्ट करा';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Save/जतन करा',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 27,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xff4c505b),
                                    child: IconButton(
                                        color: Colors.white,
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            FirebaseFirestore.instance
                                                .collection('bachatgat')
                                                .doc(id)
                                                .collection('users')
                                                .where('name', isEqualTo: mName)
                                                .get()
                                                .then((value) =>
                                                    FirebaseFirestore.instance
                                                        .collection('bachatgat')
                                                        .doc(id)
                                                        .collection('users')
                                                        .doc(
                                                            value.docs.first.id)
                                                        .collection('savings')
                                                        .add({
                                                      'name': mName,
                                                      'amount': amt,
                                                      'fine': fine,
                                                      'date': date
                                                    }));

                                            //print("//////////////////////////////////////////"+idL);
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Saving Added Successfully.",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor:
                                                    Colors.greenAccent,
                                                textColor: Colors.white,
                                                fontSize: 16.0);

                                            _formKey.currentState?.reset();
                                            dateinput.text = "";
                                            // Navigator.pop(context);

                                          }
                                        },
                                        icon: Icon(
                                          Icons.arrow_forward,
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     TextButton(
                              //       onPressed: () {
                              //         Navigator.pushNamed(context, 'login');
                              //       },
                              //       child: Text(
                              //         'Sign In/लॉगिन',
                              //         textAlign: TextAlign.left,
                              //         style: TextStyle(
                              //             decoration: TextDecoration.underline,
                              //             color: Colors.white,
                              //             fontSize: 18),
                              //       ),
                              //       style: ButtonStyle(),
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        ))
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
