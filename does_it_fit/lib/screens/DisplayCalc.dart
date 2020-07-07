import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/Unit.dart';
import './Dropdown.dart';
import '../main.dart';
import '../colors.dart' as colors;

class DisplayCalc extends StatefulWidget {
  _DisplayCalc createState() => _DisplayCalc();
}

class _DisplayCalc extends State<DisplayCalc> {
  TextEditingController myController;
  FocusNode myFocus = FocusNode();
  bool btnPressed = false;
  bool loopActive = false;
  GlobalKey<_DisplayCalc> myKey = new GlobalKey();
  int howmany1 = 0;
  String test = '.';

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    myController = TextEditingController();
    myController.text = howmany1.toString();
  }

  bool display() {
    if (getCalc(data.currentUnit1, data.currentUnit2, howmany1) >= 1 ||
        getCalc(data.currentUnit1, data.currentUnit2, howmany1).isNaN) {
      return true;
    } else {
      return false;
    }
  }

  double getCalc(Unit currentUnit1, Unit currentUnit2, int howmany) {
    double balance = data.unitList.calculate(
        data.getUnits().indexOf(data.currentUnit1),
        data.getUnits().indexOf(data.currentUnit2),
        howmany);
    return balance;
  }

  Widget canOrCant(double height) {
    if (display()) {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'You ',
          style: TextStyle(color: Colors.black, fontSize: height * 0.05),
          children: <TextSpan>[
            TextSpan(
                text: 'can', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ' fit'),
          ],
        ),
      );
    } else {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'You ',
          style: TextStyle(color: Colors.black, fontSize: height * 0.05),
          children: <TextSpan>[
            TextSpan(
                text: 'can\'t',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: colors.RED_PRIMARY)),
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
      } else if (howmany1 > 1) {
        item = value + 's';
      } else {
        item = value;
      }
      return item;
    }
    return value;
  }

  List<String> fillString() {
    List<String> strUnits = new List<String>();
    for (Unit u in data.unitList.getAllUnits()) {
      strUnits.add(u.getName());
    }
    return strUnits;
  }

  double calcHeight(double height) {
    double balance = getCalc(data.currentUnit1, data.currentUnit2, howmany1);

    if (balance >= 1) {
      return height / balance;
    } else {
      return height;
    }
  }

  //parameter - inc(increase), dec(decrease)
  void increaseCounter(String what) async {
    if (loopActive) return;

    loopActive = true;

    while (btnPressed) {
      if (what == 'inc') {
        setState(() {
          howmany1++;
          myController.text = howmany1.toString();
        });
      } else {
        setState(() {
          if (howmany1 > 0) {
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

  Color background() {
    if (display() &&
        (getCalc(data.currentUnit1, data.currentUnit2, howmany1).isNaN ||
            getCalc(data.currentUnit1, data.currentUnit2, howmany1)
                .isInfinite)) {
      return Colors.white;
    } else if (display() &&
        getCalc(data.currentUnit1, data.currentUnit2, howmany1).isFinite) {
      return colors.GREEN_SECUNDARY;
    } else {
      return colors.RED_SECUNDARY;
    }
  }

  Widget build(BuildContext context) {
    FocusScopeNode currFocus = FocusScope.of(context);
    double mainHeight = MediaQuery.of(context).size.height;
    double mainWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        if (!currFocus.hasPrimaryFocus) {
          currFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            Container(
              color: Colors.white,
            ),
            AnimatedContainer(
              alignment: Alignment.bottomCenter,
              duration: Duration(milliseconds: 500),
              color: background(),
              height: calcHeight(mainHeight),
            ),
            Container(
              width: mainWidth,
              height: mainHeight,
              //color: Colors.white,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  horizontal: mainWidth * 0.05, vertical: mainHeight * 0.2),
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
                        border: display()
                            ? Border.all(
                                color: colors.GREEN_PRIMARY,
                                width: 5,
                                style: BorderStyle.solid)
                            : Border.all(
                                color: colors.RED_PRIMARY,
                                width: 5,
                                style: BorderStyle.solid),
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
                                size: mainHeight * 0.07,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              alignment: Alignment.center,
                              child: TextField(
                                focusNode: myFocus,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                textAlign: TextAlign.center,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                  fontSize: mainHeight * 0.05,
                                ),
                                decoration: InputDecoration(
                                  hintText: howmany1.toString(),
                                  hintStyle:
                                      TextStyle(fontSize: mainHeight * 0.05),
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
                                child: Icon(Icons.add, size: mainHeight * 0.07),
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(newRoute(UnitList()));
                      },
                      child: Container(
                        //color: Colors.green,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Spacer(),
                            Flexible(
                              fit: FlexFit.tight,
                              flex:
                                  calcFlex(data.currentUnit1.getName().length),
                              child: Container(
                                //color: Colors.red,
                                alignment: Alignment.centerRight,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      //color: Colors.yellow,
                                      child: Text(
                                        //'$dropdownValue1',
                                        '${plural(data.currentUnit1.getName(), true)}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: mainHeight * 0.05,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      height: mainHeight * 0.006,
                                      width: (mainHeight * 0.027) *
                                          plural(data.currentUnit1.getName(),
                                                  true)
                                              .length,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                //color: Colors.blue,
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  size: mainHeight * 0.05,
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        //color: Colors.yellow,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'in a',
                                  style: TextStyle(
                                    fontSize: mainHeight * 0.05,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                    icon: Icon(Icons.swap_vert,
                                        size: mainHeight * 0.05),
                                    onPressed: () {
                                      setState(() {
                                        Unit temp1 = data.currentUnit1;

                                        data.currentUnit1 = data.currentUnit2;
                                        data.currentUnit2 = temp1;
                                        test = data.currentUnit1.getName();
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                      )),
                  //list 2
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(newRoute(UnitList2()));
                      },
                      child: Container(
                        //color: Colors.green,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Spacer(),
                            Flexible(
                              fit: FlexFit.tight,
                              flex:
                                  calcFlex(data.currentUnit2.getName().length),
                              child: Container(
                                //color: Colors.red,
                                alignment: Alignment.centerRight,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      //color: Colors.yellow,
                                      child: Text(
                                        //'$dropdownValue1',
                                        '${data.currentUnit2.getName()}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: mainHeight * 0.05,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      height: mainHeight * 0.006,
                                      width: (mainHeight * 0.027) *
                                          data.currentUnit2.getName().length,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                //color: Colors.blue,
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  size: mainHeight * 0.05,
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int calcFlex(int length) {
    if (length >= 1 && length <= 4) {
      return 2;
    } else if (length > 4 && length <= 8) {
      return 4;
    } else {
      return 9;
    }
  }
}

Route newRoute(Widget where) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => where,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      });
}
