

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:self_help/successful_msg.dart';



class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  // final CollectionReference _register=
  // FirebaseFirestore.instance.collection('register');
  TextEditingController dateinput = TextEditingController();
  TextEditingController regno=TextEditingController();
  //text editing controller for text field

  @override
  void initState() {

    dateinput.text = ""; //set the initial value of text field
    super.initState();

  }

  final db = FirebaseFirestore.instance;
  late String reg_no;
  String shg_name="",p_name="",s_name="",address="",gramsangh="",bankname="",bankac="",pan="",mcnt="",mob="",email="",password="";




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
                Text('Create Account/खाते तयार करा',
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
                                    hintText: "SHG Reg.No/गट नोंदणी क्रमांक",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),

                                    )),
                                onChanged: (String _val){

                                  reg_no=_val;
                                },
                                validator: (value) {
                                  if(value==null || value.isEmpty) {
                                    return 'Enter Regno/नोंदणी क्र.प्रविष्ट करा';
                                  }
                                  return null;
                                },
                                controller: regno,
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
                                    hintText: "SHG Name/बचतगटाचे नाव",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onChanged: (String _val){
                                  shg_name=_val;
                                },
                                validator: (value){
                                  if(value==null || value.isEmpty) {
                                    return 'Enter SHG Name/बचतगटाचे नाव प्रविष्ट करा';
                                  }return null;
                                },
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
                                    hintText: "President's Name/अध्यक्षाचे नाव",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onChanged: (String _val){
                                  p_name=_val;
                                },
                                validator: (value){
                                  if(value==null || value.isEmpty) {
                                    return 'Enter President Name/अध्यक्षाचे नाव प्रविष्ट करा';
                                  }return null;
                                },
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
                                    hintText: "Secretary's Name/सचिवाचे नाव",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onChanged: (String _val){
                                  s_name=_val;
                                },
                                validator: (value){
                                  if(value==null || value.isEmpty) {
                                    return 'Enter Secretary Name/सचिवाचे नाव प्रविष्ट करा';
                                  }return null;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
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
                                    labelText: "Starting Date/सुरुवातीची तारीख",
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
                                    return 'Enter Starting Date/सुरुवातीची तारीख प्रविष्ट करा';
                                  }return null;
                                },

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
                                    hintText: "Address/पत्ता",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onChanged: (String _val){
                                  address=_val;
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
                                    hintText: "GramSangh/ग्रामसंघ",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onChanged: (String _val){
                                  gramsangh=_val;
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
                                    hintText: "Member Count/सदस्य संख्या",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                onChanged: (String _val){
                                  mcnt=_val;
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

                                              var snapshot = await FirebaseFirestore.instance
                                                  .collection('bachatgat')
                                                  .doc(reg_no)
                                                  .get();
                                              if (snapshot.exists) {
                                                print("registered/////////////////////////////////////////////////////");
                                                Fluttertoast.showToast(
                                                    msg: "Bachatgat is Already Registered",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );

                                               }
                                              else {
                                                final credential = await FirebaseAuth
                                                    .instance
                                                    .createUserWithEmailAndPassword(
                                                  email: email,
                                                  password: password,
                                                ).then((value) {
                                                  FirebaseFirestore.instance
                                                      .collection('bachatgat')
                                                      .doc(reg_no)
                                                      .set({'reg_no': reg_no,
                                                    'name': shg_name,
                                                    'president': p_name,
                                                    'secretary': s_name,
                                                    'starting_date': date,
                                                    'address': address,
                                                    'gramsangh': gramsangh,
                                                    'bank_name': bankname,
                                                    'bank_ac': bankac,
                                                    'pan': pan,
                                                    'member_count': mcnt,
                                                    'mob_no': mob,

                                                  });

                                                  FirebaseFirestore.instance
                                                      .collection('bachatgat')
                                                      .doc(reg_no)
                                                      .collection('users')
                                                      .doc(value.user?.uid)
                                                      .set({
                                                    'uid':value.user?.uid,
                                                    'name': p_name,
                                                    'email': email,
                                                    'designation': 'president',
                                                    'address': address,
                                                    // 'bank_ac': bankac,
                                                    // 'pan': pan,
                                                    'mob_no': mob,
                                                    'image':''
                                                  });


                                                  Navigator.push(
                                                    context, MaterialPageRoute(
                                                      builder: (context) =>
                                                          MySuc()),
                                                  );
                                                });
                                              }

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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, 'login');
                                    },
                                    child: Text(
                                      'Sign In/लॉगिन',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.white,
                                          fontSize: 18),
                                    ),
                                    style: ButtonStyle(),
                                  ),
                                ],
                              )
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
