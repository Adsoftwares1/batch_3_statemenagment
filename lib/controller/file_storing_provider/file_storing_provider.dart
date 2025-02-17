import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FileStroingProvider extends ChangeNotifier {

   // image picker
  XFile? profileImage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // add record
  Future<void> addRecord(String name, String email, XFile profileImage) async {
    setIsLoading = true;
    try {
      // store image in firebase storage
      final imageRef = FirebaseStorage.instance
          .ref()
          .child("profileImages")
          .child(profileImage.name);
      await imageRef.putFile(File(profileImage.path));
      // get image url
      final imageUrl = await imageRef.getDownloadURL();
      // add record to firestore
      await FirebaseFirestore.instance.collection("students").add({
        "name": name,
        "email": email,
        "profileImage": imageUrl,
      });
    } catch (e) {
      print("Error in adding record: $e");
    } finally {
      setIsLoading = false;
    }
  }

  // delete record
  Future<void> deleteRecord(String url, String id) async {
    print("url: $url");
    try{
      // delete file from storage
    await FirebaseStorage.instance.refFromURL(url).delete();
    // delete record from firestore
      await FirebaseFirestore.instance.collection("students").doc(id).delete();
  
    }catch(e){
      print("Error in deleting record: $e");
      }
  }

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage = image;
    }
    notifyListeners();
    print("lasjdfkljsdfjls");
  }
}
