import 'package:does_it_fit/screens/DisplayCalc.dart';
import 'package:flutter/material.dart';

//final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Material(
      child: DisplayCalc(),
    );
  }
}

class CustomAppbar extends StatelessWidget {
  final double barHeight = 0;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      color: Colors.white,
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
    );
  }
}
