import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_menagment/controller/file_storing_provider/file_storing_provider.dart';

class GetAllRecords extends StatefulWidget {
  const GetAllRecords({super.key});

  @override
  State<GetAllRecords> createState() => _GetAllRecordsState();
}

class _GetAllRecordsState extends State<GetAllRecords> {

  late FileStroingProvider providerObject;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    providerObject = Provider.of<FileStroingProvider>(context, listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Records"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("students").snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
            return ListTile(
              title: Text(snapshot.data!.docs[index]["name"]),
              subtitle: Text(snapshot.data!.docs[index]["email"]),
              leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data!.docs[index]["profileImage"]),),
              trailing: IconButton(onPressed: (){
                // call delete function
                providerObject.deleteRecord(snapshot.data!.docs[index]["profileImage"], snapshot.data!.docs[index].id);
              }, icon: Icon(Icons.delete, color: Colors.red,)),
            );
          },);
        },
      ),
    );
  }
}
