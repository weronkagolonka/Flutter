import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './MySlider.dart';
import '../models/Unit.dart';
import '../models/Dependencies.dart';
import './Dropdown.dart';
import './home.dart';
import '../main.dart';

//PUT ALLT THE STATEFUL WIDGETS IN THIS CLASS

//String toDisplay = display();
Unit currentUnit1 = ctrl.getAllUnits()[0];
Unit currentUnit2 = ctrl.getAllUnits()[0];
double _value = currentUnit1.getMin().roundToDouble();
String dropdownValue1 = currentUnit1.getName();
String dropdownValue2 = currentUnit2.getName();
double min = currentUnit1.getMin().roundToDouble();
double max = currentUnit1.getMax().roundToDouble();
int howmany1 = _value.round();

bool display() {

  if(getCalc(currentUnit1, currentUnit2, howmany1) >= 1) {
    return true; 
  } else {
    return false;
  }

}

double getCalc(Unit currentUnit1, Unit currentUnit2, int howmany) {
  double balance = ctrl.calculate(ctrl.getAllUnits().indexOf(currentUnit1), ctrl.getAllUnits().indexOf(currentUnit2), howmany);
  return balance;
}

Widget canOrCant() {
  if (display()) {
    return RichText(
      text: TextSpan(
        text: 'You ',
        style: TextStyle(color: Colors.black, fontSize: 42),
        children: <TextSpan> [
          TextSpan(text: 'can', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: ' fit'),
          ],
      ),
      );
  } else {
    return RichText(
      text: TextSpan(
        text: 'You ',
        style: TextStyle(color: Colors.black, fontSize: 42),
        children: <TextSpan> [
          TextSpan(text: 'can\'t', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red[400])),
          TextSpan(text: ' fit'),
        ],
      ),
      );
  }
}

OutlineInputBorder colorBorder() {
  if (display()) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.green[500], width: 5, style: BorderStyle.solid),
      gapPadding: 15,
    );
  } else {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.red[500], width: 5, style: BorderStyle.solid),
    );
  }
}

Widget plural(String value) {
  String item;
  if (howmany1 == 1) {
    item = value;
  } else {
    item = value + 's';
  }
  return Text(item);
}

List<String> fillString() {
  List<String> strUnits = new List<String>();
  for (Unit u in ctrl.getAllUnits()) {
    strUnits.add(u.getName());
  }
  return strUnits;
}

/*
Widget renderList() {
  return
}
*/

class DisplayCalc extends StatefulWidget {
  _DisplayCalc createState() => _DisplayCalc();
}

class _DisplayCalc extends State<DisplayCalc> {
  TextEditingController myController;
  FocusNode myFocus = FocusNode();

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
              child: canOrCant(),       //YOU CAN FIT
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
                      icon: Icon(Icons.remove, size: 42,),
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
                      focusNode: myFocus,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 42,
                      ),
                      decoration: InputDecoration(
                        hintText: howmany1.toString(),
                        hintStyle: TextStyle(fontSize: 42),
                        border: colorBorder(),
                        enabledBorder: colorBorder(),
                        disabledBorder: colorBorder(),
                        focusedBorder: colorBorder(),
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
                      icon: Icon(Icons.add, size: 42), 
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
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      '$dropdownValue1',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                      ),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.arrow_drop_down_circle, size: 30), 
                      onPressed: () {
                        scaffoldKey.currentState.showBottomSheet((context) => 
                        Container(
                          width: 500,
                          height: 800,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text('I wanna fit...', style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),),
                              ),
                              ListView.builder(
                                controller: ScrollController(),
                                shrinkWrap: true,
                                itemCount: ctrl.getAllUnits().length,
                                itemBuilder: (context, index) {
                                  final item = ctrl.getAllUnits()[index];

                                  return ListTile(
                                    title: Text(
                                      item.getName(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 42),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          currentUnit1 = item;
                                          dropdownValue1 = item.getName();
                                          Navigator.pop(context);
                                        });
                                      },
                                  );
                                }
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(1),
                child: Text(
                  'in a', 
                style: TextStyle(
                  fontSize: 42,
                ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      '$dropdownValue2',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                      ),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.arrow_drop_down_circle, size: 30), 
                      onPressed: () {
                        scaffoldKey.currentState.showBottomSheet((context) => 
                        Container(
                          width: 500,
                          height: 800,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                //dropdownvalue is a button - MAYBE...
                                title: Text('$dropdownValue1 in a...', style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),),
                              ),
                              ListView.builder(
                                controller: ScrollController(),
                                shrinkWrap: true,
                                itemCount: ctrl.getAllUnits().length,
                                itemBuilder: (context, index) {
                                  final item = ctrl.getAllUnits()[index];

                                  return ListTile(
                                    title: Text(
                                      item.getName(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 42),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          currentUnit2 = item;
                                          dropdownValue2 = item.getName();
                                          Navigator.pop(context);
                                        });
                                      },
                                  );
                                }
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    ),
                  ),
                ],
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