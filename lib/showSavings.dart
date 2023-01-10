
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:intl/intl.dart';
import 'package:string_validator/string_validator.dart';



class showSavings extends StatefulWidget {
  const showSavings({Key? key}) : super(key: key);

  @override
  State<showSavings> createState() => _showSavingsState();
}

class _showSavingsState extends State<showSavings> {

  @override
  void initState() {
    super.initState();
    _getId();

  }

  final db = FirebaseFirestore.instance;
  late String reg_no;
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
            const Padding(padding: EdgeInsets.fromLTRB(15,25,15,0),child: Text("\n Your Savings/ तुमची बचत\n",style: TextStyle(fontSize: 25),),),
            //const Padding(padding: EdgeInsets.fromLTRB(15,5,15,0),child:Text("\n Date\t Rupees",style: TextStyle(fontSize: 20),) ,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children:
                [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child:Text("Date",style: TextStyle(fontSize: 20),),),
                  Container(
                    margin: const EdgeInsets.only(left: 20),

                    child:Text("Rupees",style: TextStyle(fontSize: 20),),)


                ],
              ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("bachatgat").doc(id).collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('savings').snapshots(),
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
                              //margin: const EdgeInsets.only(left: 20),
                              //alignment: Alignment.centerLeft,
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:[
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child:Text(
                                      DateFormat.yMMMd().format(snap[index]['date'].toDate()).toString(),
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                Container(

                                  child:Text(
                                    snap[index]['amount'].toString(),
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),


                              ],
                            ),),
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
