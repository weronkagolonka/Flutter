//import 'package:does_it_fit/models/Dependencies.dart';
import 'package:does_it_fit/screens/DisplayCalc.dart';
import 'package:does_it_fit/screens/Dropdown.dart';
import 'package:does_it_fit/screens/MySlider.dart';
import '../main.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class HomePage extends StatelessWidget { 

  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(child: CustomAppbar(), preferredSize: Size.fromHeight(0)),
      body: Material(
        color: Colors.white,
        elevation: 0,
        child: DisplayCalc(),
      ),
      );
  }
}

class CustomAppbar extends StatelessWidget {
  
  final double barHeight = 0;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
      .of(context) 
      .padding
      .top;

    return new Container(
      color: Colors.white,
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
    );
  }
}
