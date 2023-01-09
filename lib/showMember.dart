
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



class showMember extends StatefulWidget {
  const showMember({Key? key}) : super(key: key);

  @override
  State<showMember> createState() => _showMemberState();
}

class _showMemberState extends State<showMember> {

  @override
  void initState() {
    super.initState();
    _getId();

  }

  final db = FirebaseFirestore.instance;
  late String reg_no;
  String m_name="",nom_name="",address="",desg="",bankname="",bankac="",pan="",deposit="",mob="",email="",password="";
  var id;
  Future _getId() async {
    id=await SessionManager().get("bId");
    setState(() {

    });
  }

  var status;
  StreamSubscription<DocumentSnapshot>? subscription;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(15,25,15,0),child:Text("\nMembers",style: TextStyle(fontSize: 25),) ,),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("bachatgat").doc(id).collection('users').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.hasData) {
                  final snap = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: snap.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 70,
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
                              margin: const EdgeInsets.only(left: 20),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                snap[index]['name'],
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // Container(
                            //   margin: const EdgeInsets.only(right: 20),
                            //   alignment: Alignment.centerRight,
                            //   child: Text(
                            //     "\$${snap[index]['price']}",
                            //     style: TextStyle(
                            //       color: Colors.green.withOpacity(0.7),
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
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
    );
  }
}
