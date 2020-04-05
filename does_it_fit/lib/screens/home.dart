//import 'package:does_it_fit/models/Dependencies.dart';
import 'package:does_it_fit/screens/DisplayCalc.dart';
import 'package:does_it_fit/screens/Dropdown.dart';
import 'package:does_it_fit/screens/MySlider.dart';
import '../main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget { 

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: new CustomAppbar('Does it fit?'),
        ),
      body: Center(
        child: DisplayCalc(),
        ),
      );
  }
}

class CustomAppbar extends StatelessWidget {
  
  final String title;
  final double barHeight = 100.0;

  CustomAppbar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
      .of(context) 
      .padding
      .top;

    return new Container(
      color: Color.fromRGBO(38, 32, 32, 1),
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
      child: new Align(
        alignment: Alignment(-0.8, 0),
        child: new Text(
          title,
          style: new TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
