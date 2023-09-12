import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");

  late Reference ref;

  late File file;

  var title, note, imageurl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: ElevatedButton(
              onPressed: () async {
                showBottomSheet(context);
              },
              child: Text("Upload Image"),
            ))
          ],
        ));
  }

  showBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Please Choose Image",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () async {
                    var picked = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (picked != null) {
                      file = File(picked.path);
                      var rand = Random().nextInt(100000);
                      var imagename = "$rand" + basename(picked.path);
                      ref = FirebaseStorage.instance
                          .ref("images")
                          .child("$imagename");

                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.photo_outlined,
                            size: 30,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "From Gallery",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () async {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: 'admin@gmail.com', password: '11111111');
                    print(userCredential);
                    var picked = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (picked != null) {
                      file = File(picked.path);
                      var rand = Random().nextInt(100000);
                      var imagename = "$rand" + basename(picked.path);
                      ref = FirebaseStorage.instance
                          .ref("draft")
                          .child("$imagename");
                      await ref.putFile(file);
                      imageurl = await ref.getDownloadURL();
                      print(imageurl);

                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera,
                            size: 30,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "From Camera",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      )),
                ),
              ],
            ),
          );
        });
  }
}
