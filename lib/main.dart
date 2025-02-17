import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_menagment/controller/authentication_controller/login_provider.dart';
import 'package:state_menagment/controller/file_storing_provider/file_storing_provider.dart';
import 'package:state_menagment/firebase_options.dart';
import 'package:state_menagment/view/screen/authentication/login_screen.dart';
import 'package:state_menagment/view/screen/file_stroing_firebase_storage/add_record.dart';
import 'package:state_menagment/view/screen/file_stroing_firebase_storage/get_records.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // step 1: create multi provider
    return MultiProvider(
        // step 2: add provider
        providers: [
          ChangeNotifierProvider(
              // step 3: create provider
              create: (context) => AuthenticationController()),

          ChangeNotifierProvider(
              // step 3: create provider
              create: (context) => FileStroingProvider()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',

          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: GetAllRecords(),
        ));
  }
}
