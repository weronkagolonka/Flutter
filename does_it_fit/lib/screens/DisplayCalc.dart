import 'package:does_it_fit/screens/Splashscreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

Widget canOrCant(double height) {
  if (display()) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'You ',
        style: TextStyle(color: Colors.black, fontSize: height*0.05),
        children: <TextSpan> [
          TextSpan(text: 'can', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: ' fit'),
          ],
      ),
      );
  } else {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'You ',
        style: TextStyle(color: Colors.black, fontSize: height*0.05),
        children: <TextSpan> [
          TextSpan(text: 'can\'t', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red[400])),
          TextSpan(text: ' fit'),
        ],
      ),
      );
  }
}

OutlineInputBorder colorBorder(bool condition, Color good, Color bad) {
  if (condition) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: good, width: 5, style: BorderStyle.solid),
      gapPadding: 15,
    );
  } else {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: bad, width: 5, style: BorderStyle.solid),
    );
  }
}

String plural(String value, bool isFirst) {
  String item;
  if (isFirst) {
      if (howmany1 == 1) {
    item = value;
  } else {
    item = value + 's';
  }
    return item;
  }
  return value;
}

List<String> fillString() {
  List<String> strUnits = new List<String>();
  for (Unit u in ctrl.getAllUnits()) {
    strUnits.add(u.getName());
  }
  return strUnits;
}

double calcHeight(double height) {
  double balance = getCalc(currentUnit1, currentUnit2, howmany1);

  if (balance >= 1) {
    return height / balance;
  } else {
    return height;
  }
}

class DisplayCalc extends StatefulWidget {

  DisplayCalc({Key key}) : super(key: key);

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
    double mainHeight = MediaQuery.of(context).size.height;
    double mainWidth = MediaQuery.of(context).size.width;

    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
      AnimatedContainer(
        alignment: Alignment.bottomCenter,
        duration: Duration(milliseconds: 500),
        color: display() ? Colors.green[100] : Colors.red[100],
        height: calcHeight(mainHeight),
      ),
      Container(
        width: mainWidth,
        height: mainHeight,
        //color: Colors.red[100],
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: mainWidth * 0.05, vertical: mainHeight * 0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                //color: Colors.blue,
                alignment: Alignment.center,
                child: canOrCant(mainHeight),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: display() ? Border.all(color: Colors.green[500], width: 5, style: BorderStyle.solid) : Border.all(color: Colors.red[500], width: 5, style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                ),
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      //long tap - number changes faster
                      child: Container(
                        color: Colors.yellow,
                        child: IconButton(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 8),
                          icon: Icon(Icons.remove, size: mainHeight*0.08,),
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
                      flex: 3,
                      child: Container(
                        color: Colors.blue,
                        //margin: EdgeInsets.symmetric(vertical: mainHeight*0.01),
                        child: TextField(
                          focusNode: myFocus,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                            fontSize: mainHeight*0.05,
                          ),
                          decoration: InputDecoration(
                            hintText: howmany1.toString(),
                            hintStyle: TextStyle(fontSize: mainHeight*0.05),
                            border: InputBorder.none,
                            //contentPadding: EdgeInsets.symmetric(vertical: mainHeight*0.005),
                          ),
                          controller: myController,
                          onChanged: (String input) {
                            setState(() {
                                if (input == '') {
                                  howmany1 = 0;
                                } else {
                                  //myController.text = input;
                                  howmany1 = int.parse(input);
                                }
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.yellow,
                        child: IconButton(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 8),
                          icon: Icon(Icons.add, size: mainHeight*0.07), 
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
              ),
              //list1
              Expanded(
                flex: 2,
                child: Container(
                  //color: Colors.blue,
                  alignment: Alignment.center,
                  child: FlatButton.icon(
                    icon: Icon(Icons.arrow_drop_down_circle, size: mainHeight*0.05),
                    label: Text(
                    '$dropdownValue1',
                    style: TextStyle(
                      fontSize: mainHeight*0.05,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => UnitList()));
                  }, 
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  //color: Colors.yellow,
                  child: Text(
                    'in a', 
                    style: TextStyle(
                      fontSize: mainHeight*0.05,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ),
              //list 2
              Expanded(
                flex: 2,
                child: Container(
                  //color: Colors.blue,
                  alignment: Alignment.center,
                  child: FlatButton.icon(
                    icon: Icon(Icons.arrow_drop_down_circle, size: mainHeight*0.05),
                    label: Text(
                    '$dropdownValue2',
                    style: TextStyle(
                      fontSize: mainHeight*0.05,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => UnitList2()));
                  }, 
                  ),
                ),
              ),
          ],
        ),
        ),
    ],
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