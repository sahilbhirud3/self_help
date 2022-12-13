import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:self_help/login.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDash extends StatefulWidget {
  const MyDash({Key? key}) : super(key: key);

  @override
  State<MyDash> createState() => _MyDashState();
}

class _MyDashState extends State<MyDash> {
  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
  }

  String name = "";
  String email1 = "";
  bool? switchValue;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final User? user = FirebaseAuth.instance.currentUser;
  //String? email = FirebaseAuth.instance.currentUser?.email;

  Future _getDataFromDatabase() async {
    print("_getDataFromDatabase called");
    await FirebaseFirestore.instance
        .collection('bachatgat')
        .where('bachatgat.user.uid',isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots().listen((data) { name = data.docs[0]["name"];})  ;


  }
      //.where('bachatgat.user.uid'=FirebaseAuth.instance.currentUser?.uid)
  //.doc(FirebaseAuth.instance.currentUser?.uid)
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = FirebaseAuth.instance.currentUser != null
        ? true
        : false; // check user logged in or not
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
                                    'hi',
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
            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Text('bagha'),
            //     ToggleButtons(
            //         children: [
            //           Icon(Icons.ac_unit),
            //           Icon(Icons.call),
            //         ],
            //         onPressed: (int index) {
            //           setState(() {
            //             for (int buttonIndex = 0;
            //                 buttonIndex < _selectedWeather.length;
            //                 buttonIndex++) {
            //               if (buttonIndex == index) {
            //                 _selectedWeather[buttonIndex] = true;
            //                 Fluttertoast.showToast(
            //                     msg: "you selected $index",
            //                     toastLength: Toast.LENGTH_SHORT,
            //                     gravity: ToastGravity.BOTTOM,
            //                     timeInSecForIosWeb: 1,
            //                     backgroundColor: Colors.red,
            //                     textColor: Colors.white,
            //                     fontSize: 16.0);
            //               } else {
            //                 _selectedWeather[buttonIndex] = false;
            //               }
            //             }
            //           });
            //         },
            //         isSelected: _selectedWeather),Text('taka'),
            //   ],
            // ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ToggleSwitch(
                  minWidth: 200.0,
                  initialLabelIndex: 1,
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
                    print('switched to: $index');
                  },
                ),
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
