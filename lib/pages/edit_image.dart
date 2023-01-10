import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:self_help/main.dart';
import 'package:self_help/user/user_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:self_help/widgets/appbar_widget.dart';
import 'package:image_picker/image_picker.dart';

class EditImagePage extends StatefulWidget {
  const EditImagePage({Key? key}) : super(key: key);

  @override
  _EditImagePageState createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  void initState() {
    super.initState();
    _getId();
  }

  String id = "", image1 = "";

  Future _getId() async {
    id = await SessionManager().get("bId");
    setState(() {});
    await FirebaseFirestore.instance
        .collection('bachatgat')
        .doc(id)
        .collection('users')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .listen((data) {
      image1 = data.docs[0]["image"];

      setState(() {});
    });
  }

  var user = UserData.myUser;
  ImagePicker imagePicker = ImagePicker();
  late File file;
  late String imageUrl;
  late File _image;
  bool _loading = false;
  final FirebaseStorage _storage = FirebaseStorage
      .instance; //find your link in your storage console like this screenshot https://i.imgur.com/gW35HJk.png
  late UploadTask _uploadTask;
  String imageURL = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              width: 330,
              child: const Text(
                "Upload a photo of yourself:",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                  width: 330,
                  child: GestureDetector(
                    onTap: () async {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      if (file == null) return;
                      print('${file?.path}');

                      final String? uid =
                          FirebaseAuth.instance.currentUser?.uid;

                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDirImages =
                          referenceRoot.child('profile');

                      Reference referenceImageToUpload =
                          referenceDirImages.child(uid!);
                      try {
                        await referenceImageToUpload.putFile(File(file.path));
                        imageURL =
                            await referenceImageToUpload.getDownloadURL();
                        FirebaseFirestore.instance
                            .collection('bachatgat')
                            .doc(id)
                            .collection('users')
                            .doc(uid)
                            .update({
                          'image': imageURL,
                        }).then((value) => { Fluttertoast.showToast(
                            msg: "Profile Image Updated Successfully.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.greenAccent,
                            textColor: Colors.white,
                            fontSize: 16.0
                        )});

                      } catch (err) {}
                      // final image = await ImagePicker()
                      //     .pickImage(source: ImageSource.gallery);
                      //
                      // if (image == null) return;
                      //
                      // final location = await getApplicationDocumentsDirectory();
                      // final name = basename(image.path);
                      // final imageFile = File('${location.path}/$name');
                      // final newImage =
                      //     await File(image.path).copy(imageFile.path);
                      // setState(
                      //     () => user = user.copy(imagePath: newImage.path));
                    },
                    child: image1.isNotEmpty?Image.network(image1):Image.network('assets/shg_logo.png'),
                  ))),
          Padding(
              padding: EdgeInsets.only(top: 40),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 330,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Tap on Image',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}
