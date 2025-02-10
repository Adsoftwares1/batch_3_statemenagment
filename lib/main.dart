import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_menagment/controller/authentication_controller/login_provider.dart';
import 'package:state_menagment/view/screen/authentication/login_screen.dart';

void main() {
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
        ],
        child: MaterialApp(
          title: 'Flutter Demo',

          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: LoginScreen(),
        ));
  }
}
