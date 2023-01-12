
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:self_help/showInstallments.dart';
import 'package:string_validator/string_validator.dart';



class showLoan extends StatefulWidget {
  const showLoan({Key? key}) : super(key: key);

  @override
  State<showLoan> createState() => _showLoanState();
}

class _showLoanState extends State<showLoan> {

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
  num sumTotal=0,fineTotal=0;
  StreamSubscription<DocumentSnapshot>? subscription;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(15,25,15,0),child: Text("\n Your Loans/ तुमचे कर्ज\n",style: TextStyle(fontSize: 25),),),
            //const Padding(padding: EdgeInsets.fromLTRB(15,5,15,0),child:Text("\n Date\t Rupees",style: TextStyle(fontSize: 20),) ,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children:
                [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child:Text("Type",style: TextStyle(fontSize: 20),),),
                  Container(
                    margin: const EdgeInsets.only(left: 20),

                    child:Text("Date",style: TextStyle(fontSize: 20),),),
                  Container(
                    margin: const EdgeInsets.only(left: 20),

                    child:Text("Amount",style: TextStyle(fontSize: 20),),),
                  Container(
                    margin: const EdgeInsets.only(left: 20),

                    child:Text("View",style: TextStyle(fontSize: 20),),),



                ],
              ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("bachatgat").doc(id).collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('loan').orderBy('date').snapshots(),
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
                                      snap[index]['type'],
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child:Text(
                                      DateFormat.yMMMd().format(snap[index]['date'].toDate()).toString(),
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),

                                Container(

                                  child:Text(
                                    snap[index]['issuedAmount'].toString(),
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                  Container(
                                    margin:
                                    const EdgeInsets.only(left: 5),
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(

                                      onPressed: () {

    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => showInstallments(lId:snap[index].id)),
    );



                                      }, icon: Icon(Icons.remove_red_eye),color:Colors.lightBlue ,

                                    ),
                                  ),
                                  // Container(
                                  //   alignment: Alignment.centerRight,
                                  //   child:Text(
                                  //     snap[index]['fine'].toString(),
                                  //     style: const TextStyle(
                                  //       color: Colors.black54,
                                  //       fontWeight: FontWeight.bold,
                                  //       fontSize: 16,
                                  //     ),
                                  //   ),
                                  // ),


                              ],
                            ),),


                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            // FutureBuilder(
            //   future: FirebaseFirestore.instance.collection("bachatgat").doc(id).collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('savings').get(),
            //   builder: (BuildContext context,
            //       AsyncSnapshot<QuerySnapshot> querySnapshot) {
            //     if (querySnapshot.hasError) {
            //       return Text("Something went wrong");
            //     }
            //
            //     // if (snapshot.hasData && !snapshot.data!.exists) {
            //     //   return Text("Document does not exist");
            //     // }
            //
            //     if (querySnapshot.connectionState == ConnectionState.done) {
            //       querySnapshot.data!.docs.forEach((doc) {
            //         sumTotal = sumTotal + doc.get('amount'); // make sure you create the variable sumTotal somewhere
            //         fineTotal = fineTotal + doc.get('fine');
            //       });
            //       return Text("Your Total Saving is : ${sumTotal}\n \nTotal Fine Paid: ${fineTotal}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),);
            //     }
            //
            //     return Text("loading");
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
