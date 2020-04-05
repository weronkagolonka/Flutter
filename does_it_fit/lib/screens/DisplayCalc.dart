import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './MySlider.dart';
import '../models/Unit.dart';
import '../models/Dependencies.dart';
import './Dropdown.dart';
import './home.dart';
import '../main.dart';

//PUT ALLT THE STATEFUL WIDGETS IN THIS CLASS

String toDisplay = display();
Unit currentUnit1 = ctrl.getAllUnits()[0];
Unit currentUnit2 = ctrl.getAllUnits()[0];
double _value = currentUnit1.getMin().roundToDouble();
String dropdownValue1 = currentUnit1.getName();
String dropdownValue2 = currentUnit2.getName();
double min = currentUnit1.getMin().roundToDouble();
double max = currentUnit1.getMax().roundToDouble();
int howmany1 = _value.round();

String display() {

  int maybe = getCalc(currentUnit1, currentUnit2, howmany1).round();
  String text;

  if(getCalc(currentUnit1, currentUnit2, howmany1) >= 1) {
    if (howmany1 == 1) {
      text = 'You can fit one $dropdownValue1 in one $dropdownValue2';
    } else {
      text = 'You can fit $howmany1 ${dropdownValue1}s in one $dropdownValue2';
      
    }
  } else {
    text = 'You cannot fit $howmany1 $dropdownValue1 in one $dropdownValue2! (or maybe $maybe...)';
  }

  return text;
}

double getCalc(Unit currentUnit1, Unit currentUnit2, int howmany) {
  double balance = ctrl.calculate(ctrl.getAllUnits().indexOf(currentUnit1), ctrl.getAllUnits().indexOf(currentUnit2), howmany);
  return balance;
}


class DisplayCalc extends StatefulWidget {
  _DisplayCalc createState() => _DisplayCalc();
}

class _DisplayCalc extends State<DisplayCalc> {
  TextEditingController myController;

  List<String> fillString() {
    List<String> strUnits = new List<String>();
    for (Unit u in ctrl.getAllUnits()) {
      strUnits.add(u.getName());
    }
    return strUnits;
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  initState() {
    super.initState();
    myController = TextEditingController();
    myController.text = howmany1.toString();
  }

  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 600,
      color: Colors.red[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(1),
              child: Text(
                'You can fit'
              ),
            )
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(1),
                    child: IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        setState(() {
                          if(howmany1 > 0) {
                          howmany1 -= 1;
                        } else {
                          howmany1 = 0;
                        }
                        myController.text = howmany1.toString();
                      });
                      }
                      ),
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(1),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                      textAlign: TextAlign.center,
                      showCursor: false,
                      decoration: InputDecoration(
                        hintText: howmany1.toString(),
                        hintStyle: TextStyle(),
                      ),
                      controller: myController,
                      onChanged: (String input) {
                        setState(() {
                            if (input == '') {
                              howmany1 = 0;
                            } else {
                              myController.text = input;
                              howmany1 = int.parse(input);
                            }
                        });
                      },
                      
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(1),
                    child: IconButton(
                      icon: Icon(Icons.add_circle_outline), 
                      onPressed: () {
                        setState(() {
                          howmany1 += 1;
                          myController.text = howmany1.toString();
                        });
                      }
                    ),
                  ),
                ),
              ],
              ),
            ),
            Expanded(
              child: DropdownButton<String>(
                hint: Text('lolo'),
                value: dropdownValue1,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 20,
                underline: Container(
                  height: 0,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue1 = newValue;
                    
                    for (Unit u in ctrl.getAllUnits()) {
                      if (u.getName() == dropdownValue1) {
                        currentUnit1 = u;
                      }
                    }
                    toDisplay = display();
                  });
                },
                items: fillString().map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                    );
                }).toList(), 
                ),
              ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(1),
                child: Text('in a'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(1),
                child: DropdownButton<String>(
                  hint: Text('lolo'),
                  value: dropdownValue2,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 20,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue2 = newValue;
                      for (Unit u in ctrl.getAllUnits()) {
                        if (u.getName() == dropdownValue2) {
                          currentUnit2 = u;
                        }
                      }
                      toDisplay = display();
                    });
                  },
                  items: fillString().map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      );
                  }).toList(), 
                ),
              ),
              ),
        ],
      ),
    );
  }

  /*
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DropdownButton<String>(
      hint: Text('lolo'),
      value: dropdownValue1,
      icon: Icon(Icons.arrow_downward),
      iconSize: 20,
      underline: Container(
        height: 0,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue1 = newValue;
          
          for (Unit u in ctrl.getAllUnits()) {
            if (u.getName() == dropdownValue1) {
              currentUnit1 = u;
            }
          }
          toDisplay = display();
        });
      },
      items: fillString().map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
          );
      }).toList(), 
      ),
      DropdownButton<String>(
        hint: Text('lolo'),
        value: dropdownValue2,
        icon: Icon(Icons.arrow_downward),
        iconSize: 20,
        underline: Container(
          height: 0,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue2 = newValue;
            for (Unit u in ctrl.getAllUnits()) {
              if (u.getName() == dropdownValue2) {
                currentUnit2 = u;
              }
            }
            toDisplay = display();
          });
        },
        items: fillString().map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
            );
        }).toList(), 
      ),
      SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.red[700],
        inactiveTrackColor: Colors.red[100],
        trackShape: RectangularSliderTrackShape(), //custom track: | | | | | |
        trackHeight: 5.0,
        thumbColor: Colors.redAccent,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0), //custom thumb: doesn't move
        overlayColor: Colors.blue.withAlpha(32),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0), 
      ), 
      child: Slider(
        min: min,
        max: max,
        value: _value, 
        divisions: 100,
        onChanged: (double newValue) {
          setState(() {
            _value = newValue;
            toDisplay = display();
            if (_value == currentUnit1.getMax().roundToDouble()) {
              max = max + 100;
            } else if (_value < currentUnit1.getMax().roundToDouble()) {
              max = currentUnit1.getMax().roundToDouble();
            }
          });
        }
      ),
    ),
    //Text('${display()}'),
    //Text(getCalc(currentUnit1, currentUnit2, _value.round()).toString()),
    Text('$toDisplay')
    ],);
  }
  */
}