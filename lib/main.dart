import 'package:apartment_complex/welcome_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Amplify Flutter Packages
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';

// Generated in previous step
import 'amplifyconfiguration.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  Future<void> _configureAmplify() async {

    // Add any Amplify plugins you want to use
    final authPlugin =  AmplifyAPI();
    await Amplify.addPlugin(authPlugin);

    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      if (kDebugMode) {
        print("Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
      }
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configureAmplify();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apartments',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const WelcomeScreen(),
    );
  }
}

