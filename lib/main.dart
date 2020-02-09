import 'package:flutter/material.dart';
import 'package:ungshoppee/screens/home.dart';
import 'package:ungshoppee/utility/my_style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.brown),
      title: MyStyle().appName,
      home: Home(),
    );
  }
}
