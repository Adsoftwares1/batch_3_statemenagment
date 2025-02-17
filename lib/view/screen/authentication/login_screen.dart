import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_menagment/controller/authentication_controller/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // step 1: create instance of authentication controller
  late AuthenticationController authenticationController;

  @override
  void initState() {
    // step 2: initialize authentication controller
    authenticationController =
        Provider.of<AuthenticationController>(context, listen: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Full UI is rebuild");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            // step 3: use consumer to listen to authentication controller
            Consumer<AuthenticationController>(
              builder: (context, providerObj, child) {
                print("Button is rebuild");
                return ElevatedButton(
                  onPressed: () {
                    // step 4: call login function
                    providerObj.Login(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors
                        .amberAccent, // Set the button color to amber accent
                  ),
                  child: providerObj.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                );
              },
            ),

            Consumer<AuthenticationController>(
              builder: (context, providerObj, child) {
                print("Counter is rebuild");
                return Text("${providerObj.counter}");
              }
            ),

            ElevatedButton(
              onPressed: () {
                authenticationController.counter += 1;
              },
              child: const Text('Increment'),
            ),

          ],
        ),

      ),

    );
  }
}
