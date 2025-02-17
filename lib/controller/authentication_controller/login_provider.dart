

import 'package:flutter/material.dart';
import 'package:state_menagment/view/screen/file_stroing_firebase_storage/add_record.dart';

class AuthenticationController extends ChangeNotifier {

  int _counter = 0;

  int get counter => _counter;

  set counter(int value) {
    _counter = value;
    notifyListeners();
  }

  // decalre loading varaible for ui state chaning
  bool _isLoading = false;
  // get loading state
  bool get isLoading => _isLoading;
  // set loading state

  set isLoading(bool value) {
    _isLoading = value;
    // notify listeners
    notifyListeners();
  }


  // login function
  Future<void> Login(BuildContext context) async{
    // set loading state
    isLoading = true;
    // delay for 2 seconds
    await Future.delayed(const Duration(seconds: 3));
    // set loading state
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddUSerInformationFirestore()));
    isLoading = false;
  }

  
}
