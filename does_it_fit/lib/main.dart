// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Does is fit?',
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: new TestWidgets('Does it fit?'),
        ),
        body: Center(
          child: Text('yuppp', textAlign: TextAlign.right,),
        )
      ),
    );
  }

}

class TestWidgets extends StatelessWidget {
  
  final String title;
  final double barHeight = 100.0;

  TestWidgets(this.title);

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