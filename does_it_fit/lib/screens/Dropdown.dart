//import 'package:does_it_fit/models/Dependencies.dart';
import 'package:does_it_fit/screens/DisplayCalc.dart';
import 'package:flutter/material.dart';
import '../models/Unit.dart';
//import '../models/Dependencies.dart';
import 'package:does_it_fit/main.dart';

/*
String dropdownValue = ctrl.getAllUnits()[0].getName();
Unit currentUnit = ctrl.getAllUnits()[0];

class MyDropdown extends StatefulWidget {
  MyDropdown({Key key}) : super(key: key);

  _Dropdown createState() => _Dropdown();

  Unit getCurrentUnit() {
    return currentUnit;
  }

  String getCurrentValue() {
    return dropdownValue;
  }

}

class _Dropdown extends State<MyDropdown> {
  
  List<String> fillString() {
    List<String> strUnits = new List<String>();
    for (Unit u in ctrl.getAllUnits()) {
      strUnits.add(u.getName());
    }
    return strUnits;
  }
  
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text('lolo'),
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 20,
      underline: Container(
        height: 0,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          
          for (Unit u in ctrl.getAllUnits()) {
            if (u.getName() == dropdownValue) {
              currentUnit = u;
            }
          }
        });
      },
      items: fillString().map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
          );
      }).toList(), 
      );
  }
}
*/