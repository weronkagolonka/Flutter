import 'package:does_it_fit/models/StateDate.dart';
import 'package:does_it_fit/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

StateData data = StateData();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Does is fit?',
      theme: ThemeData(fontFamily: 'Product Sans'),
      home: HomePage(),
      //theme: ThemeData(fontFamily: ),
    );
  }
}

//add units here
