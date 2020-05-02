import 'dart:async';

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
double _value = 0;
String dropdownValue1 = currentUnit1.getName();
String dropdownValue2 = currentUnit2.getName();
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
  bool btnPressed = false;
  bool loopActive = false;


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

  //parameter - inc(increase), dec(decrease)
  void increaseCounter(String what) async {

    if(loopActive) return;
    
    loopActive = true;

    while(btnPressed) {
      if(what == 'inc') {
        setState(() {
          howmany1 ++;
          myController.text = howmany1.toString();
        });
      } else {
        setState(() {
          if(howmany1 > 0) {
            howmany1--;
          } else {
            howmany1 = 0;
          }
          myController.text = howmany1.toString();
        });
      }
      await Future.delayed(Duration(milliseconds: 200));
    }

    loopActive = false;    

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      //long tap - number changes faster
                      child: Listener(
                        onPointerDown: (details) {
                          btnPressed = true;
                          increaseCounter('dec');
                        },
                        onPointerUp: (details) {
                          btnPressed = false;
                        },
                        child: Icon(
                          Icons.remove,
                          size: mainHeight*0.07,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        //color: Colors.blue,
                        alignment: Alignment.center,
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
                            //contentPadding: EdgeInsets.all(0),
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
                      child: Listener(
                        onPointerDown: (details) {
                          btnPressed = true;
                          increaseCounter('inc');
                        },
                        onPointerUp: (details) {
                          btnPressed = false;
                        },
                        child: Container(
                        //color: Colors.yellow,
                        //alignment: Alignment.center,
                        child: Icon(Icons.add, size: mainHeight*0.07),
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
                      Navigator.of(context).push(newRoute(UnitList()));
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
                      Navigator.of(context).push(newRoute(UnitList2()));
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
}

Route newRoute(Widget where) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => where,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    }
  );
}