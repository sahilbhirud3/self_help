import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dashboard.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  //List<String> _bachatgatName = <String>['Jagadamba', 'Samrudhi', 'Umang'];
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  String dropdownValue = 'one';
  var bName;
  var selectedBachatgat;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.png'), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 35, top: 150),
                child: Text(
                  'Welcome/\nस्वागत आहे',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 33,
                  ),
                ),
              ),
              SingleChildScrollView(
                  child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5,
                    right: 35,
                    left: 35),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[

                  new StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('bachatgat').snapshots(),
                    builder: (context, snapshot){
                      if (!snapshot.hasData) return const Center(
                        child: const CupertinoActivityIndicator(),
                      );
                      var length = snapshot.data!.docs.length;
                      DocumentSnapshot ds = snapshot.data!.docs[length - 1];
                      var _queryCat = snapshot.data!.docs;
                      return new Container(
                        padding: EdgeInsets.only(bottom: 16.0),
                        //width: screenSize.width*0.9,
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                                flex: 2,
                                child: new Container(
                                  padding: EdgeInsets.fromLTRB(12.0,10.0,10.0,10.0),
                                  child: new Text("BachatGat\n बचतगट",style: TextStyle(fontSize: 15)),

                                )
                            ),

                            new Expanded(
                              flex: 4,
                              child:new InputDecorator(
                                decoration: const InputDecoration(
                                  //labelText: 'Activity',
                                  hintText: 'Choose/निवडा',
                                  hintStyle: TextStyle(
                                    //color: primaryColor,
                                    fontSize: 16.0,
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.normal,

                                  ),
                                ),
                                isEmpty: bName == null,
                                child: new DropdownButtonFormField(
                                  value: bName,
                                  isDense: true,
                                  //iconSize: 0.0,
                                  //isExpanded: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      bName = newValue;

                                      //dropDown = false;
                                      print(bName);
                                    });
                                  },


                                  validator:(value) {
                              if (value == null) {
                              return 'Select Bachatgat';
                              }
                              return null;
                              } ,
                                  itemHeight: null,
                                  items: snapshot.data!.docs.map((DocumentSnapshot document) {
                                    return new DropdownMenuItem<String>(
                                        value: document.get('name'),
                                        child: new Container(
                                          decoration: new BoxDecoration(
                                             // color: primaryColor,
                                              borderRadius: new BorderRadius.circular(5)
                                          ),
                                          height: 20.0,
                                          padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
                                          //color: primaryColor,
                                          child: new Text(document.get('name'),),
                                        )
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                ),




                  // DropdownButton(
                      //   items: _bachatgatName
                      //       .map((value) => DropdownMenuItem(
                      //             child: Text(
                      //               value,
                      //               style: TextStyle(color: Color(0xff11b719)),
                      //             ),
                      //             value: value,
                      //           ))
                      //       .toList(),
                      //   onChanged: (selected) {
                      //     setState(() {
                      //       selectedBachatgat = selected;
                      //     });
                      //   },
                      //   value: selectedBachatgat,
                      //   isExpanded: false,
                      //   hint: Text('Select Bachatgat Name'),
                      // ),
                      // StreamBuilder<QuerySnapshot>(
                      //     stream: FirebaseFirestore.instance.collection("bachatgat").snapshots(),
                      //     builder: (context, snapshot) {
                      //      if (!snapshot.hasData)
                      //         const Text("Loading.....");
                      //       else {
                      //         List<DropdownMenuItem> _bachatgatName = [];
                      //         for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      //           DocumentSnapshot snap = snapshot.data!.docs[i];
                      //           _bachatgatName.add(
                      //             DropdownMenuItem(
                      //               child: Text(
                      //                 snap.id,
                      //                 style: TextStyle(color: Color(0xff11b719)),
                      //               ),
                      //               value: "${snap.id}",
                      //             ),
                      //           );
                      //         }//for
                      //         return Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: <Widget>[
                      //
                      //             DropdownButton(
                      //               items: _bachatgatName,
                      //               onChanged: (value) {
                      //
                      //                 setState(() {
                      //                   selectedBachatgat = value;
                      //                 });
                      //               },
                      //               value: selectedBachatgat,
                      //               isExpanded: false,
                      //               hint: new Text(
                      //                 "choose",
                      //                 style: TextStyle(color: Color(0xff11b719)),
                      //               ),
                      //             ),
                      //           ],
                      //         );
                      //       }//else
                      //     }
                      // ),
                      // ,
                      TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Email/ई-मेल',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                          ),
                          onChanged: (String _val) {
                            email = _val;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Email/ई-मेल.प्रविष्ट करा';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Password/पासवर्ड',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              fillColor: Colors.grey.shade100,
                              filled: true),
                          onChanged: (String _val) {
                            password = _val;
                          }),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              onPressed: () async {
                                try {
                                  if (_formKey.currentState!.validate())
                                    {


                                  final credential = await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: email, password: password);

                                  // await FirebaseFirestore.instance
                                  //     .collection('bachatgat')
                                  //     .where('bachatgat.')
                                  //     .where('bachatgat.user.uid',isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                                  //     .snapshots().listen((data) { name = data.docs[0]["name"];})  ;



                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyDash()),
                                  );}
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    Fluttertoast.showToast(
                                        msg: "No user found for that email",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    print('No user found for that email.');
                                  } else if (e.code == 'wrong-password') {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Wrong password provided for that user.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    print(
                                        'Wrong password provided for that user.');
                                  }
                                }
                              },
                              icon: Icon(Icons.arrow_forward),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'register');
                              },
                              child: Text(
                                'Register/नोंदणी',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 18,
                                    color: Color(0xff4c505b)),
                              )),
                          TextButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await _auth.sendPasswordResetEmail(
                                      email: email);
                                  Fluttertoast.showToast(
                                      msg: "Reset Password Link has been sent ",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.lightBlueAccent,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                              child: Text(
                                'Forget Password\n/पासवर्ड विसरलात',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 18,
                                    color: Color(0xff4c505b)),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ))
            ],
          )),
    );
  }
}
