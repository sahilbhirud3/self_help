
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:self_help/widgets/display_image_widget.dart';



class removeMember extends StatefulWidget {
  const removeMember({Key? key}) : super(key: key);

  @override
  State<removeMember> createState() => _removeMemberState();
}

class _removeMemberState extends State<removeMember> {

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
      body: Container(
        // decoration : BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage('assets/login.png'), fit: BoxFit.fill,),
        // ),
      child:SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(15,25,15,0),child:Text("\nMembers / सभासद",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),) ,),

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
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    height: 60.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image:NetworkImage(snap[index]['image']),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 20),width:150,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      snap[index]['name'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                    const EdgeInsets.only(left: 20),
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(

                                      onPressed: () {

                                        showAlertDialog(BuildContext context) {

                                          // set up the buttons
                                          Widget cancelButton = TextButton(
                                            child: Text("Cancel"),
                                            onPressed:  () {
                                              Navigator.of(context).pop();
                                            },
                                          );
                                          Widget continueButton = TextButton(
                                            child: Text("Continue"),
                                            onPressed:  () {
                                              FirebaseFirestore.instance
                                                  .collection("bachatgat").doc(id).collection('users')
                                                  .where("uid", isEqualTo :snap[index]['uid'])
                                                  .get().then((value) {

                                                    //await FirebaseStorage.instance.ref().child(snap[index]['image']).delete();

                                                FirebaseFirestore.instance.collection("bachatgat").doc(id).collection('users').doc(value.docs.first.id).delete().then((value){

    //print("Deleted:::::::::::::::::::::::::::::: "+snap[index]['name']);

                                                  Fluttertoast.showToast(
                                                      msg: "Member Deleted Successfully.",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                      Colors.deepOrange,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                });
                                              });
                                              Navigator.of(context).pop();


                                            },
                                          );

                                          // set up the AlertDialog
                                          AlertDialog alert = AlertDialog(
                                            title: Text("AlertDialog"),
                                            content: Text("Do you want to remove member ?"),
                                            actions: [
                                              cancelButton,
                                              continueButton,
                                            ],
                                          );

                                          // show the dialog
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alert;
                                            },
                                          );
                                        }
                                        showAlertDialog(context);



                                      }, icon: Icon(Icons.delete),color:Colors.deepOrange ,

                                    ),
                                  ),

                                ],
                              )
                            ),
                            // InkWell(
                            //
                            //     child: DisplayImage(
                            //       imagePath: snap[index]['image'].isNotEmpty?snap[index]['image']:'assets/shg_logo.png',
                            //       onPressed: () {},
                            //     )),

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
      ),)
    );
  }
}
