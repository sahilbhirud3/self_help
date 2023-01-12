
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:intl/intl.dart';
import 'package:string_validator/string_validator.dart';



class showInstallments extends StatefulWidget {
  final String lId;

  const showInstallments({Key? key,required this.lId}) : super(key: key);

  @override
  State<showInstallments> createState() => _showInstallmentsState();
}

class _showInstallmentsState extends State<showInstallments> {

  @override
  void initState() {
    super.initState();
    _getId();

  }

  final db = FirebaseFirestore.instance;
  late String reg_no;
  var id,type,date,amount,remainingAmount,amountWithInterest,name;
  Future _getId() async {
    id=await SessionManager().get("bId");
    setState(() {

    });
    // FirebaseFirestore.instance.collection("bachatgat").doc(id).collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('loan').doc(widget.lId).snapshots().then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    //     print(doc["first_name"]);
    //   });
    // });
    await FirebaseFirestore.instance.collection("bachatgat").doc(id).collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('loan').doc(widget.lId)
        .snapshots()
        .listen((data) {
      type = data["type"];
      name = data["name"];
      date= data["date"];
      amount= data["issuedAmount"];
      remainingAmount= data["remAmount"];
      amountWithInterest= data["amountWithInterest"];
      setState(() {

      });
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
            const Padding(padding: EdgeInsets.fromLTRB(15,25,15,0),child: Text("\n Loan Details/कर्ज तपशील\n",style: TextStyle(fontSize: 25),),),

            Container(
              alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 20),
                child:Text("Name :\t$name\nLoan Type :\t$type\nDate :\t${DateFormat.yMMMd().format(date.toDate()).toString()}\nLoan Amount :\t$amount\nAmount With Interest :\t$amountWithInterest\nRemaining Amount :\t$remainingAmount\n\n",style: TextStyle(fontSize: 20),),),





            const Padding(padding: EdgeInsets.fromLTRB(15,5,15,0),child:Text("Installment Details/\nहप्त्याचे तपशील\n",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),) ,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children:
                [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child:Text("No.",style: TextStyle(fontSize: 20),),),
                  Container(
                    margin: const EdgeInsets.only(left: 20),

                    child:Text("Date",style: TextStyle(fontSize: 20),),),
                  Container(
                    margin: const EdgeInsets.only(left: 20),

                    child:Text("Amount",style: TextStyle(fontSize: 20),),)


                ],
              ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("bachatgat").doc(id).collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('loan').doc(widget.lId).collection('installments').orderBy('date').snapshots(),
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
                                     '${index+1}',
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
                                    snap[index]['amount'].toString(),
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
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

          ],
        ),
      ),
    );
  }
}
