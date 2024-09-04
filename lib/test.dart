import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_image == null) {
      // No image selected
      return;
    }

    // Upload the image to Firebase Storage
    Reference storageReference = FirebaseStorage.instance.ref().child('images/${DateTime.now()}.png');
    UploadTask uploadTask = storageReference.putFile(_image!);
    await uploadTask.whenComplete(() => print('Image uploaded to Firebase Storage'));

    // Get the download URL of the uploaded image
    String imageUrl = await storageReference.getDownloadURL();

    // Create a document in Firestore with some sample data
    await FirebaseFirestore.instance.collection('images').add({
      'url': imageUrl,
      'timestamp': FieldValue.serverTimestamp(), // Add a timestamp
      'description': 'This is a sample description', // Add a description
    });

    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload to Firestore'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(
                    _image!,
                    height: 200.0,
                  ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload Image to Firestore'),
            ),
          ],
        ),
      ),
    );
  }
}