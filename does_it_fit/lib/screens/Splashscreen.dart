import 'dart:async';

import 'package:does_it_fit/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen>{  
  @override
  initState() {
    super.initState();
    startTime();
  }

  Widget build(BuildContext contex) {
    return Material(
      child: Container(
        color: Colors.green[500],
        child: Center(
          child: Text(
            'nice',
            style: TextStyle(
              fontSize: 42,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  startTime() async {
    var duration = new Duration(seconds: 2);
    return new Timer(duration, route);
  }

  route() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
