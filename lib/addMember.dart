
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



class addMember extends StatefulWidget {
  const addMember({Key? key}) : super(key: key);

  @override
  State<addMember> createState() => _addMemberState();
}

class _addMemberState extends State<addMember> {
  // final CollectionReference _register=
  // FirebaseFirestore.instance.collection('register');
  TextEditingController dateinput = TextEditingController();
  TextEditingController mname=TextEditingController();
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
  String m_name="",nom_name="",address="",desg="",bankname="",bankac="",pan="",deposit="",mob="",email="",password="";
String id="";

  Future _getId() async {
    id=await SessionManager().get("bId");
    }
// id=SessionManager().get("bId");




  final _formKey=GlobalKey<FormState>();
  var status;
  StreamSubscription<DocumentSnapshot>? subscription;
  //final DocumentReference documentReference=FirebaseFirestore.instance.doc("register");
  DateTime? date;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration : BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Add Member/सदस्य नोंदणी',
                  style: TextStyle(color: Colors.white, fontSize: 20),)
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
                          key:_formKey,
                          child:Column(
                            children: [
                              TextFormField(
                                style: TextStyle(color: Colors.white,height: 0.3),
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
                                    hintText: "Member Name/सदस्याचे नाव",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),

                                    )),
                                onChanged: (String _val){

                                  m_name=_val;
                                },
                                validator: (value) {
                                  if(value==null || value.isEmpty) {
                                    return 'Enter Member Name/सदस्याचे नाव प्रविष्ट करा';
                                  }
                                  return null;
                                },
                                controller: mname,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                style: TextStyle(color: Colors.white,height: 0.3),
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
                                    hintText: "Nominee Name/वारसदाराचे नाव",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onChanged: (String _val){
                                  nom_name=_val;
                                },
                                validator: (value){
                                  if(value==null || value.isEmpty) {
                                    return 'Enter Nominee Name/वारसदाराचे नाव प्रविष्ट करा';
                                  }return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              // TextFormField(
                              //   style: TextStyle(color: Colors.white,height: 0.3),
                              //   decoration: InputDecoration(
                              //       enabledBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(10),
                              //         borderSide: BorderSide(
                              //           color: Colors.white,
                              //         ),
                              //       ),
                              //       focusedBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(10),
                              //         borderSide: BorderSide(
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //       hintText: "Secretary's Name/सचिवाचे नाव",
                              //       hintStyle: TextStyle(color: Colors.white),
                              //       border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(10),
                              //       )),
                              //   onChanged: (String _val){
                              //     s_name=_val;
                              //   },
                              //   validator: (value){
                              //     if(value==null || value.isEmpty) {
                              //       return 'Enter Secretary Name/सचिवाचे नाव प्रविष्ट करा';
                              //     }return null;
                              //   },
                              // ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              TextFormField(
                                textAlignVertical: TextAlignVertical.top,
                                style: TextStyle(color: Colors.white,height: 0.3,),
                                controller: dateinput,

                                //editing controller of this TextField
                                decoration:
                                InputDecoration(


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
                                    ),icon: Icon(Icons.calendar_today,color:Colors.white),
                                    labelText: "Entry Date/प्रवेशाची तारीख",
                                    labelStyle: TextStyle(fontSize: 15,color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                readOnly: true,  //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context, initialDate: DateTime.now(),
                                      firstDate: DateTime(2018) ,//- not to allow to choose before today.
                                      lastDate: DateTime.now()
                                  );

                                  if(pickedDate != null ){
                                    print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                                    date=pickedDate; //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                    setState(() {
                                      dateinput.text = formattedDate; //set output date to TextField value.
                                    });
                                  }else{
                                    print("Date is not selected");
                                  }
                                },
                                validator: (value){
                                  if(value==null || value.isEmpty) {
                                    return 'Enter Entry Date/प्रवेशाची तारीख प्रविष्ट करा';
                                  }return null;
                                },

                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // TextFormField(
                              //   style: TextStyle(color: Colors.white,height: 0.3),
                              //   decoration: InputDecoration(
                              //       enabledBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(10),
                              //         borderSide: BorderSide(
                              //           color: Colors.white,
                              //         ),
                              //       ),
                              //       focusedBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(10),
                              //         borderSide: BorderSide(
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //       hintText: "/पत्ता",
                              //       hintStyle: TextStyle(color: Colors.white),
                              //       border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(10),
                              //       )),
                              //   onChanged: (String _val){
                              //     address=_val;
                              //   },
                              //
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),

                              TextFormField(

                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(color: Colors.white,height: 0.3),
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
                                    hintText: "Bank Name/बँकेचे नाव",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onChanged: (String _val){
                                  bankname=_val;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(

                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(color: Colors.white,height: 0.3),
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
                                    hintText: "Bank A/c No./बँक खाते क्रमांक",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onChanged: (String _val){
                                  bankac=_val;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(

                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(color: Colors.white,height: 0.3),
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
                                    hintText: "PAN No./पॅन कार्ड क्रमांक",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onChanged: (String _val){
                                  pan=_val;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(

                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(color: Colors.white,height: 0.3),
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
                                    hintText: "Deposit/जमा ठेव संख्या",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onChanged: (String _val){
                                  deposit=_val;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(

                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(color: Colors.white,height: 0.3),
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
                                    hintText: "Mobile No./मोबाईल क्र.",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onChanged: (String _val){
                                  mob=_val;
                                },
                                validator: (value){
                                  if(value==null || value.isEmpty) {
                                    return 'Enter Mobile No/मोबाईल क्र.प्रविष्ट करा';
                                  }return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(

                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(color: Colors.white,height: 0.3),
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
                                    hintText: "Email/ई-मेल",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onChanged: (String _val){
                                  email=_val;
                                },
                                validator: (value){
                                  if(value==null || value.isEmpty) {
                                    return 'Enter Email/ई-मेल.प्रविष्ट करा';
                                  }return null;
                                },

                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                style: TextStyle(color: Colors.white,height: 0.3),
                                obscureText: true,
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
                                    hintText: "Password/पासवर्ड",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onChanged: (String _val){
                                  password=_val;
                                },
                                validator: (value){
                                  if(value==null || value.isEmpty) {
                                    return 'Enter Password/पासवर्ड प्रविष्ट करा';
                                  }return null;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sign Up/\nनोंदणीकृत करा',
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
                                          try {

                                            if(_formKey.currentState!.validate())  {

                                              // var snapshot = await FirebaseFirestore.instance
                                              //     .collection('bachatgat')
                                              //     .doc(reg_no)
                                              //     .get();
                                              // if (snapshot.exists) {
                                              //   print("registered/////////////////////////////////////////////////////");
                                              //   Fluttertoast.showToast(
                                              //       msg: "Bachatgat is Already Registered",
                                              //       toastLength: Toast.LENGTH_SHORT,
                                              //       gravity: ToastGravity.BOTTOM,
                                              //       timeInSecForIosWeb: 1,
                                              //       backgroundColor: Colors.red,
                                              //       textColor: Colors.white,
                                              //       fontSize: 16.0
                                              //   );
                                              //
                                              // }
                                               // String idL=_getId() as String;
                                                final credential = await FirebaseAuth
                                                    .instance
                                                    .createUserWithEmailAndPassword(
                                                  email: email,
                                                  password: password,
                                                ).then((value) {
                                                  FirebaseFirestore.instance
                                                      .collection('bachatgat')
                                                      .doc(id)
                                                      .collection('users')
                                                      .doc(value.user?.uid)
                                                      .set({
                                                    'uid':value.user?.uid,
                                                    'name': m_name,
                                                    'nominee':nom_name,
                                                    'entryDate':date,
                                                    'email': email,
                                                    'designation': 'member',
                                                    'address': address,
                                                    'bank_ac': bankac,
                                                    'pan': pan,
                                                    'deposit':deposit,
                                                    'mob_no': mob,
                                                    'image':''
                                                  });

                            //print("//////////////////////////////////////////"+idL);
                                                  Fluttertoast.showToast(
                                                      msg: "Member Added Successfully.",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.greenAccent,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0
                                                  );

                                                  _formKey.currentState?.reset();
                                                  dateinput.text = "";
                                                  // Navigator.pop(context);


                                                }
                                                );


                                            }
                                          } on FirebaseAuthException catch (e) {
                                            if (e.code == 'weak-password') {
                                              Fluttertoast.showToast(
                                                  msg: "The password provided is too weak.",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0
                                              );
                                              print('The password provided is too weak.');
                                            } else if (e.code == 'email-already-in-use') {
                                              Fluttertoast.showToast(
                                                  msg: "The account already exists for that email.",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0
                                              );
                                              print('The account already exists for that email.');
                                            }
                                          } catch (e) {
                                            print(e);
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
                        )
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
