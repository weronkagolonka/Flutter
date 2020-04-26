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
  ctrl.createUnit('beer', 500);
  ctrl.createUnit('30l bag', 30000);
  ctrl.createUnit('Pidgeon\'s feather', 12.75);
  ctrl.createUnit('Fridge', 538882.92);
  ctrl.createUnit('Saturn V', 8856610210);
  ctrl.createUnit('Fiat Multipla', 7908864);
  ctrl.createUnit('Potato chip', 2.12);
  ctrl.createUnit('Rice grain', 0.055);
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

