import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:self_help/pages/edit_address.dart';
import 'package:self_help/pages/edit_email.dart';
import 'package:self_help/pages/edit_image.dart';
import 'package:self_help/pages/edit_name.dart';
import 'package:self_help/pages/edit_phone.dart';

import '../user/user.dart';
import '../widgets/display_image_widget.dart';
import '../user/user_data.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    _getId();

  }
  var id;
  String name="",image1="";
  String email="";String phone="";String address="";

  Future _getId() async {
    id = await SessionManager().get("bId");
    setState(() {

    });
    await FirebaseFirestore.instance
        .collection('bachatgat')
        .doc(id)
        .collection('users')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .listen((data) {
      name = data.docs[0]["name"];
      email = data.docs[0]["email"];
      phone = data.docs[0]["mob_no"];
      address = data.docs[0]["address"];
      image1=data.docs[0]['image'];
      setState(() {

      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final user = UserData.myUser;

    return Scaffold(
      body: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 10,
          ),
          Center(
              child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(64, 105, 225, 1),
                    ),
                  ))),
          InkWell(
              onTap: () {
                navigateSecondPage(EditImagePage());
              },
              child: DisplayImage(
                imagePath: image1.isNotEmpty?image1:'assets/shg_logo.png',
                onPressed: () {},
              )),
          buildUserInfoDisplay(name, 'Name', EditNameFormPage()),
          buildUserInfoDisplay(phone, 'Phone', EditPhoneFormPage()),
        Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'email',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Container(
                    width: 350,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ))),
                    child: Row(children: [
                      Expanded(
                          child: TextButton(
                              onPressed: () {

                              },
                              child: Text(
                                email,
                                style: TextStyle(fontSize: 16, height: 1.4),
                              ))),

                    ]))
              ],
            )),
          buildUserInfoDisplay(address, 'Address', EditAddressFormPage()),

        ],
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: TextStyle(fontSize: 16, height: 1.4),
                            ))),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                  ]))
            ],
          ));

  // Widget builds the About Me Section


  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
