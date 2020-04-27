import 'package:does_it_fit/models/Dependencies.dart';
import 'package:does_it_fit/screens/DisplayCalc.dart';
import 'package:does_it_fit/screens/home.dart';
import 'package:flutter/material.dart';

Dependencies ctrl = new Dependencies();

void main() {
  //testuje zmiany
  //10 basic units
  //values from 0.001 to 1000
  //znowu
  //(name, volume, min:overwrite,max:overwrite)
  //cm^3
  //name, height, width(depth), length
  
  ctrl.createUnit('beer', 16.8, 6.33, 6.33);
  ctrl.createUnit('30l bag', 44, 21, 30);
  ctrl.createUnit('Pidgeon\'s feather', 16, 0.5, 2);
  ctrl.createUnit('Fridge', 100, 65, 60);
  ctrl.createUnit('Saturn V', 10966.704, 1005.84, 1005.84);
  ctrl.createUnit('Fiat Multipla', 167, 187.1, 399.4);
  ctrl.createUnit('Potato chip', 4, 0.2, 3);
  ctrl.createUnit('Rice grain', 0.7, 0.3, 0.3);
  ctrl.createUnit('Big box', 24, 40, 56);
  ctrl.createUnit('Small box', 6, 4, 7);
  //ctrl.createUnit('Tent', 1.0);
  //ctrl.createUnit('Beer', 1.0);

  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if(!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Does is fit?',
        theme: ThemeData(fontFamily: 'Product Sans'),
        home: HomePage(),
        //theme: ThemeData(fontFamily: ),
      ),
    );
  }

}

//add units here

