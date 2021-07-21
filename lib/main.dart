import 'package:flutter/material.dart';
import 'package:basketballstats/Screens/HomeScreen.dart';
import 'package:splashscreen/splashscreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:SplashScreen(
        seconds: 8,
        backgroundColor: Colors.white,
        image: Image.asset('assets/test4.gif') ,
        loaderColor: Colors.white,
        photoSize: 195.0,
        navigateAfterSeconds: HomeScreen(),
    )
    ) ;
  }
}

