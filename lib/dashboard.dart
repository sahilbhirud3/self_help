import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:self_help/addSavings.dart';
import 'package:self_help/showMember.dart';
import 'addMember.dart';
import 'navBar.dart';
import 'package:self_help/login.dart';
import 'package:self_help/register.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDash extends StatefulWidget {
  final String bID;

  //MyDash({this.bID});
  const MyDash({
    Key? key,
    required this.bID,
  }) : super(key: key);

  @override
  State<MyDash> createState() => _MyDashState();
}

class _MyDashState extends State<MyDash> {
  //static get bID => bID;
  bool _swap = true;

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();

  }

  String name = "";

  String bName = "";
  String email1 = "";
  String desg = "";
  bool? switchValue;
  bool? isLog;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final User? user = FirebaseAuth.instance.currentUser;
  String id='';
  //dynamic bName;

  //String? email = FirebaseAuth.instance.currentUser?.email;

  Future _getDataFromDatabase() async{

    print("_getDataFromDatabase called");
     await FirebaseFirestore.instance
        .collection('bachatgat')
        .doc(widget.bID)
        .collection('users')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .listen((data) {
      name = data.docs[0]["name"];
      desg = data.docs[0]["designation"];
      
      setState(() {

      });
    });
    await FirebaseFirestore.instance
        .collection('bachatgat')
        .doc(widget.bID)
        .snapshots()
        .listen((data) {
      bName = data.get("name");
      setState(() {

      });
    });
   

  }

  //.where('bachatgat.user.uid'=FirebaseAuth.instance.currentUser?.uid)
  //.doc(FirebaseAuth.instance.currentUser?.uid)
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = FirebaseAuth.instance.currentUser != null ? true : false;
    bool isVisible = true;
    if (isLoggedIn) {
      print('logged in/////////////////////////////////////////////////////////////');
    }
    else
      print('Not Logged IN////////////////////////////////////////////////////////////');

    if (desg != 'president') isVisible = false;

    final viewContent = Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              label: Text('Member/सभासद'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => showMember()),
                );
              },
              style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black,
                  elevation: 20,
                  backgroundColor: Colors.lightBlueAccent,
                  fixedSize: Size(150, 50)),
              icon: Icon(FontAwesomeIcons.userGroup),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              label: Text('Add Savings/बचत जमा करा'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyRegister()),
                );
              },
              style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black,
                  elevation: 20,
                  backgroundColor: Colors.lightBlueAccent,
                  fixedSize: Size(150, 50)),
              icon: Icon(FontAwesomeIcons.piggyBank),
            ),
          ],
        ),
      ],
    );

    final addContent = Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            label: Text('Add Member/सभासद जोडा'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => addMember()),
              );
            },
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.black,
                elevation: 20,
                backgroundColor: Colors.lightBlueAccent,
                fixedSize: Size(150, 50)),
            icon: Icon(FontAwesomeIcons.userGroup),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            label: Text('Add Savings/बचत जमा करा'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => addSavings()),
              );
            },
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.black,
                elevation: 20,
                backgroundColor: Colors.lightBlueAccent,
                fixedSize: Size(150, 50)),
            icon: Icon(FontAwesomeIcons.piggyBank),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            label: Text('Allocate Loan/कर्ज वाटप करा'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyRegister()),
              );
            },
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.black,
                elevation: 20,
                backgroundColor: Colors.lightBlueAccent,
                fixedSize: Size(150, 50)),
            icon: Icon(FontAwesomeIcons.moneyBillTrendUp),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            label: Text('Pay Loan/कर्ज हफ्ता जमा करा'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyRegister()),
              );
            },
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.black,
                elevation: 20,
                backgroundColor: Colors.lightBlueAccent,
                fixedSize: Size(150, 50)),
            icon: Icon(FontAwesomeIcons.moneyBill),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            label: Text('Income/उत्पन्न'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyRegister()),
              );
            },
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.black,
                elevation: 20,
                backgroundColor: Colors.lightBlueAccent,
                fixedSize: Size(150, 50)),
            icon: Icon(FontAwesomeIcons.indianRupeeSign),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            label: Text('Rules & Instructions/नियम व सुचना'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyRegister()),
              );
            },
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.black,
                elevation: 20,
                backgroundColor: Colors.lightBlueAccent,
                fixedSize: Size(150, 50)),
            icon: Icon(FontAwesomeIcons.circleExclamation),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            label: Text('Goverment Schemes/शासकीय योजना'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyRegister()),
              );
            },
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.black,
                elevation: 20,
                backgroundColor: Colors.lightBlueAccent,
                fixedSize: Size(150, 50)),
            icon: Icon(FontAwesomeIcons.clipboardList),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            label: Text('Other Expenses/\nइतर खर्च'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyRegister()),
              );
            },
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.black,
                elevation: 20,
                backgroundColor: Colors.lightBlueAccent,
                fixedSize: Size(150, 50)),
            icon: Icon(FontAwesomeIcons.receipt),
          ),
        ],
      ),
    ]);

    var swapTile = new Container(
      child: _swap ? viewContent : addContent,
    );

    if (isLoggedIn) {
      return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: Text(name),
        ),
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(0),
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
                                    child: Text(bName),
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
                Visibility(
                  child: ToggleSwitch(
                    minWidth: 200.0,
                    initialLabelIndex: _swap ? 0 : 1,
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
                      print('switched to: $_swap');
                      setState(() {
                        _swap = !_swap;
                      });
                    },
                  ),
                  visible: isVisible,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 7,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: swapTile, //getCustomContainer(),
              ),
            ),
            // Visibility(
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         ElevatedButton.icon(
            //           label: Text('Add Member/सभासद जोडा'),
            //           onPressed: () {
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(builder: (context) => MyRegister()),
            //             );
            //           },
            //           style: ElevatedButton.styleFrom(
            //               shadowColor: Colors.black,
            //               elevation: 20,
            //               backgroundColor: Colors.lightBlueAccent,
            //               fixedSize: Size(150, 50)),
            //           icon: Icon(FontAwesomeIcons.userGroup),
            //         ),
            //         const SizedBox(
            //           height: 20,
            //         ),
            //         ElevatedButton.icon(
            //           label: Text('Add Savings/बचत जमा करा'),
            //           onPressed: () {
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(builder: (context) => MyRegister()),
            //             );
            //           },
            //           style: ElevatedButton.styleFrom(
            //               shadowColor: Colors.black,
            //               elevation: 20,
            //               backgroundColor: Colors.lightBlueAccent,
            //               fixedSize: Size(150, 50)),
            //           icon: Icon(FontAwesomeIcons.piggyBank),
            //         ),
            //       ],
            //     ),
            //     visible: true),

            //sideMenu Bar Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     SideMenu(
            //       // Page controller to manage a PageView
            //       controller: page,
            //       // Will shows on top of all items, it can be a logo or a Title text
            //       title: Image.asset('assets/images/easy_sidemenu.png'),
            //       // Will show on bottom of SideMenu when displayMode was SideMenuDisplayMode.open
            //       footer: Text('demo'),
            //       // Notify when display mode changed
            //       onDisplayModeChanged: (mode) {
            //         print(mode);
            //       },
            //       // List of SideMenuItem to show them on SideMenu
            //       items: items,
            //     ),
            //     Expanded(
            //       child: PageView(
            //         controller: page,
            //         children: [
            //           Container(
            //             child: Center(
            //               child: Text('Dashboard'),
            //             ),
            //           ),
            //           Container(
            //             child: Center(
            //               child: Text('Settings'),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),

            //newDuplicate
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
