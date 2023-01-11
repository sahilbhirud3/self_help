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

class addRules extends StatefulWidget {
  const addRules({Key? key}) : super(key: key);

  @override
  State<addRules> createState() => _addRulesState();
}

class _addRulesState extends State<addRules> {
  // final CollectionReference _register=
  // FirebaseFirestore.instance.collection('register');
  //TextEditingController dateinput = TextEditingController();
  TextEditingController rname = TextEditingController();

  //text editing controller for text field

  @override
  void initState() {
    //dateinput.text = ""; //set the initial value of text field
    super.initState();
    _getId();
  }

  final db = FirebaseFirestore.instance;

  //late String reg_no;
//Future<String> id = await SessionManager().get("key");
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
              'Add Rules/नियम टाका',
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
                            children: [
                              TextFormField(
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
                                    hintText: "Rule/नियम",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onChanged: (String _val) {
                                  r_name = _val;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Rule/नियम प्रविष्ट करा';
                                  }
                                  return null;
                                },
                                controller: rname,
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Save/जतन करा',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xff4c505b),
                                    child: IconButton(
                                      color: Colors.white,
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          FirebaseFirestore.instance
                                              .collection('bachatgat')
                                              .doc(id)
                                              .collection('rules')
                                              .doc()
                                              .set({'rule': r_name});

                                          //print("//////////////////////////////////////////"+idL);
                                          Fluttertoast.showToast(
                                              msg: "Rule Added Successfully.",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  Colors.greenAccent,
                                              textColor: Colors.white,
                                              fontSize: 16.0);

                                          _formKey.currentState?.reset();

                                          // Navigator.pop(context);

                                        }
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("bachatgat")
                          .doc(id)
                          .collection("rules")
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
                                            snap[index]['rule'],
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
                                            
                                               onPressed: () {

                                                 showAlertDialog(BuildContext context) {

                                                   // set up the buttons
                                                   Widget cancelButton = TextButton(
                                                     child: Text("Cancel"),
                                                     onPressed:  () {
                                                       Navigator.of(context).pop();
                                                     },
                                                   );
                                                   Widget continueButton = TextButton(
                                                     child: Text("Continue"),
                                                     onPressed:  () {
                                                       FirebaseFirestore.instance
                                                           .collection("bachatgat").doc(id).collection('rules')
                                                           .where("rule", isEqualTo :snap[index]['rule'])
                                                           .get().then((value){

                                                         FirebaseFirestore.instance.collection("bachatgat").doc(id).collection('rules').doc(value.docs.first.id).delete().then((value){
                                                           print("Deleted:::::::::::::::::::::::::::::: "+snap[index]['rule']);

                                                           Fluttertoast.showToast(
                                                               msg: "Rule Deleted Successfully.",
                                                               toastLength: Toast.LENGTH_SHORT,
                                                               gravity: ToastGravity.BOTTOM,
                                                               timeInSecForIosWeb: 1,
                                                               backgroundColor:
                                                               Colors.deepOrange,
                                                               textColor: Colors.white,
                                                               fontSize: 16.0);
                                                         });
                                                       });
                                                       Navigator.of(context).pop();


                                                     },
                                                   );

                                                   // set up the AlertDialog
                                                   AlertDialog alert = AlertDialog(
                                                     title: Text("AlertDialog"),
                                                     content: Text("Do you want to remove this rule ?"),
                                                     actions: [
                                                       cancelButton,
                                                       continueButton,
                                                     ],
                                                   );

                                                   // show the dialog
                                                   showDialog(
                                                     context: context,
                                                     builder: (BuildContext context) {
                                                       return alert;
                                                     },
                                                   );
                                                 }
                                                 showAlertDialog(context);



                                               }, icon: Icon(Icons.delete),color:Colors.deepOrange ,
                                              
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
