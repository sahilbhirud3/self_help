//import 'dart:ffi';
//import 'dart:math';




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:self_help/login.dart';
import 'package:self_help/register.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDash extends StatefulWidget {
  final String bID;
  //MyDash({this.bID});
  const MyDash({Key? key,required this.bID,}) : super(key: key);

  @override
  State<MyDash> createState() => _MyDashState();
}

class _MyDashState extends State<MyDash> {
  //static get bID => bID;
  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
  }

  String name = "";
  String email1 = "";
  String desg="";
  bool? switchValue;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final User? user = FirebaseAuth.instance.currentUser;
  //String? email = FirebaseAuth.instance.currentUser?.email;

  Future _getDataFromDatabase() async {
    print("_getDataFromDatabase called");
    await FirebaseFirestore.instance
        .collection('bachatgat')
        .doc(widget.bID)
        .collection('users')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots().listen((data) { name = data.docs[0]["name"];desg = data.docs[0]["designation"];})  ;


  }
      //.where('bachatgat.user.uid'=FirebaseAuth.instance.currentUser?.uid)
  //.doc(FirebaseAuth.instance.currentUser?.uid)
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = FirebaseAuth.instance.currentUser != null
        ? true
        : false;
    bool isVisible=true;
    // check user logged in or not
    if(desg!='president')
      isVisible=false;
    if (isLoggedIn) {
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                    const EdgeInsetsDirectional.fromSTEB(16, 40, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Colors.black12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                2, 2, 2, 2),
                            child: Container(
                              width: 50,
                              height: 50,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'assets/shg_logo.png',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Text(
                                    'Hi',
                                    //style: FlutterFlowTheme.of(context).title3,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        4, 0, 0, 0),
                                    child: Text(name),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
              const SizedBox(
              height: 20,
            ),


            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                    Visibility(child:
                    ToggleSwitch(
                      minWidth: 200.0,
                      initialLabelIndex: 0,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 2,

                      labels: const ['View/माहिती पहा', 'Add/माहिती टाका'],
                      icons: const [
                        FontAwesomeIcons.solidEye,
                        FontAwesomeIcons.solidPenToSquare
                      ],
                      activeBgColors: const [
                        [Colors.blue],
                        [Colors.blue]
                      ],
                      onToggle: (index) {

                        if(index==1 && desg=='president'){
                          print("President////////////////////////////////////////////////////////////");


                        }
                        print('switched to: $index');
                      },

                    ),visible: isVisible,
                    )

              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                extraWidget("es", "Dapur", true),
                //extraWidget("belanja", "Memasak", false),
                extraWidget("tirai", "Tirai Kecil", true),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                extraWidget("teras", "Teras", false),
                //extraWidget("belanja", "Belanja", true),
                extraWidget("tirai", "Tirai Besar", true),
              ],
            ),



          ],

        ),


      );

    } else {
      // if user isn't logged in, open login page
      return const MaterialApp(
        home: MyLogin(),
      );
    }
  }
}
Column extraWidget(String img, String name, bool isSelected) {
  return Column(
    children: [
      Stack(
        children: [
          Container(
            height: 90,
            width: 120,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              boxShadow: [BoxShadow(color:Colors.black54,blurRadius: 10.0,)],

              borderRadius:BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Container(
              margin: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/shg_logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
              child: GestureDetector(onTap: ()=>{
                if(name=='Teras')
                {
                print('I am Teras /////////////////////////////////////')

              //  Navigator.push(context,
              //  MaterialPageRoute(
                //builder: (context) => MyRegister()),
                //);

              }

              },
  ),

            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: isSelected == true
                ? Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Icon(
                  Icons.check_circle,
                  color: Colors.deepOrange,
                ),
              ),
            )
                : Container(),
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      )
    ],
  );
}
