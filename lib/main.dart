import 'package:flutter/material.dart';
import 'package:notificaja_uni/loginpage.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override  
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'NotifyCaja',
        theme: ThemeData(
          canvasColor: Color.fromRGBO( 156, 156, 156, 0.3)
        ),
        home: LoginPage()
      );
  }
}