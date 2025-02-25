import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:state_menagment/controller/file_storing_provider/file_storing_provider.dart';

class AddUSerInformationFirestore extends StatefulWidget {
  const AddUSerInformationFirestore({super.key});

  @override
  State<AddUSerInformationFirestore> createState() =>
      _AddUSerInformationFirestoreState();
}

class _AddUSerInformationFirestoreState
    extends State<AddUSerInformationFirestore> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  late FileStroingProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    provider = Provider.of<FileStroingProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // button to pick image
            ElevatedButton(
              onPressed: () async {
                await provider.pickImage();
              },
              child: Text("Pick Image"),
            ),

            Consumer<FileStroingProvider>(
                builder: (context, providerObject, child) {
              return providerObject.profileImage != null
                  ? CircleAvatar(
                      backgroundImage:
                          FileImage(File(providerObject.profileImage!.path)),
                    )
                  : Text("No Image Selected");
            }),
            // text field for name
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Name",
              ),
            ),
            // text field for email
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),

            // button to add record
            Consumer<FileStroingProvider>(
                builder: (context, providerObject, child) {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffa3361f),
                  ),
                  onPressed: () async {
                    providerObject.addRecord(nameController.text,
                        emailController.text, providerObject.profileImage!);
                  },
                  child: providerObject.isLoading
                      ? CircularProgressIndicator()
                      : Text("Add Record"));
            }),
          ],
        ),
      ),
    );
  }
}
