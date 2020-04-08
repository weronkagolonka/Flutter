import 'package:does_it_fit/screens/MyTextFormField.dart';
import 'package:does_it_fit/screens/Splashscreen.dart';
import 'package:flutter/foundation.dart';
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


/*
Widget renderList() {
  return
}
*/

class DisplayCalc extends StatefulWidget {
  DisplayCalc({Key key}) : super(key: key);

  _DisplayCalc createState() => _DisplayCalc();
}

class _DisplayCalc extends State<DisplayCalc> {
  //static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PersistentBottomSheetController _controller;
  TextEditingController myController, addController, addController2, addController3, addController4;
  FocusNode myFocus = FocusNode();
  FocusNode myFocus1 = FocusNode();
  FocusNode myFocus2 = FocusNode();
  FocusNode myFocus3 = FocusNode();
  FocusNode myFocus4 = FocusNode();
  bool text1;
  double length; 
  double height;
  double depth;
  String name;

  @override
  void dispose() {
    myController.dispose();
    addController.dispose();
    addController2.dispose();
    addController3.dispose();
    addController4.dispose();
    super.dispose();
  }

  initState() {
    super.initState();
    myController = TextEditingController();
    addController = TextEditingController();
    addController2 = TextEditingController();
    addController3 = TextEditingController();
    addController4 = TextEditingController();
    myController.text = howmany1.toString();
    text1=false;
  }

  //1 - length, 2 - height, 3 - depth
  Widget setForm(String hintText, bool isNumeric, int queue, controller, focus) {
    if (isNumeric) {
      return Material(
        elevation: 7,
        shadowColor: Colors.black,
        borderOnForeground: true,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: TextFormField(
          validator: (value) {
            if(value.isEmpty) {
              return '';
            }
            return null;
          },
          style: TextStyle(
            fontSize: 42,
          ),
          controller: controller,
          focusNode: focus,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            //helperText: ' ',
            errorText: null,
            contentPadding: EdgeInsets.all(10),
            hintText: hintText,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.red[500], width: 5, style: BorderStyle.solid),
              gapPadding: 15,
            ),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.red[500], width: 5, style: BorderStyle.solid),
              gapPadding: 15,
            ),
          ),
          onChanged: (String input) {
            setState(() {
              if (input != '') {
                double value = double.parse(input);
                if (queue == 1) {
                  length = value;
                } else if (queue == 2) {
                  height = value;
                } else if (queue == 3) {
                  depth = value;
                }
                text1 = true;
              } else {
                text1 = false;
              } 
            });
          },
        ),
      );
    } else {
      return Material(
        elevation: 7,
        shadowColor: Colors.black,
        borderOnForeground: true,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: TextFormField(
          validator: (value) {
            if(value.isEmpty) {
              return '';
            }
            return null;
          },
          style: TextStyle(
            fontSize: 42,
          ),
          controller: controller,
          focusNode: focus,
          decoration: InputDecoration(
            //helperText: ' ',
            errorText: null,
            contentPadding: EdgeInsets.all(10),
            hintText: hintText,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.red[500], width: 5, style: BorderStyle.solid),
              gapPadding: 15,
            ),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.red[500], width: 5, style: BorderStyle.solid),
              gapPadding: 15,
            ),
          ),
          onChanged: (String input) {
            setState(() {
              if (input != '' && queue == 0) {
                name = input;
                text1 = true;
              } else {
                text1 = false;
              } 
            });
          },
        ),
      );
    }
  }

  Widget setSubtitle(String data) {
    return Text(
      data,
      style: TextStyle(
        fontSize: 32,
      ),
    );
  }

  Widget setUnit() {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Text(
          'cm,',
          style: TextStyle(
            fontSize: 32,
          ),
        ),
      );
  }

  addItem() {

    _controller = scaffoldKey.currentState.showBottomSheet((context) {
      return Container(
      width: 500,
      height: 800,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      //constraints: BoxConstraints.tightForFinite(),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Form(
        //key: _formKey,
        //autovalidate: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'I wanna add...',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
            setForm('item name', false, 0, addController, myFocus1),
            setSubtitle('with a length of...'),
              //width: 500,
            Row(
              children: <Widget>[
                Expanded(
                  child: setForm('eg. 666', true, 1, addController2, myFocus2),
                ),
                setUnit(),
              ],
            ),
            setSubtitle('height of...'),
            Row(
              children: <Widget>[
                Expanded(
                  child: setForm('eg. 1337', true, 2, addController3, myFocus3),
                ),
                setUnit(),
              ],
            ),
            setSubtitle('and depth of...'),
            Row(
              children: <Widget>[
                //to do: ALLOW DECIMALS
                Expanded(
                  child: setForm('eg. 69', true, 3, addController4, myFocus4),
                ),
                setUnit(),
              ],
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 138),
              child: Text(
                'add',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                ),
              disabledColor: Colors.grey,
              color: Colors.green[500],
              onPressed: () {
                //_formKey.currentState.validate();
                  if(name != null && length != null && height != null && depth != null) {
                    filledFormBtn(length, height, depth, name);  
                }
              },
              )
          ],
      ),
      ),
      );
    });
  }

  filledFormBtn(double length, double height, double depth, String name) {
    double volume = length * height * depth;
    ctrl.createUnit(name, volume);
    _controller.close();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SplashScreen()));
    //_controller.close();
    addController.clear();
    addController2.clear();
    addController3.clear();
    addController4.clear();
  }

  Widget renderList(bool isFirst) {
    String value, title;
    Unit curr;

    if (isFirst) {
      value = dropdownValue1;
      title = 'I wanna add...';
      curr = currentUnit1;
    } else {
      value = dropdownValue2;
      title = 'in a...';
      curr = currentUnit2;
    }

    return Container(
      alignment: Alignment.center,
      child: FlatButton.icon(
        icon: Icon(Icons.arrow_drop_down_circle, size: 30),
        label: Text(
        '${plural(value, isFirst)}',
        style: TextStyle(
          fontSize: 38,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          ),
        ),
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
                  title: Text(title, style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),),
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
                            if (isFirst) {
                              currentUnit1 = item;
                              dropdownValue1 = item.getName();
                            } else {
                              currentUnit2 = item;
                              dropdownValue2 = item.getName();
                            }
                            Navigator.pop(context);
                          });
                        },
                    );
                  }
                ),
                ListTile(
                  title: FlatButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      addItem();
                    }, 
                    label: Text('add new', style: TextStyle(color: Colors.black, fontSize: 42, fontWeight: FontWeight.bold),),
                    icon: Icon(Icons.add_circle_outline, size: 30, color: Colors.black,), 
                  ),
                ),
              ],
            ),
          ),
        );
      }, 
      ),
      );
  }


  Widget build(BuildContext context) {
    return Container(
      width: 400,
      color: Colors.red[100],
      alignment: Alignment.topCenter,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 70),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: canOrCant(),       //YOU CAN FIT
            )
          ),
          /*
          IconButton(icon: Icon(Icons.help), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SplashScreen()));
          }),
          */
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
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
                    padding: EdgeInsets.all(10),
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
                        border: colorBorder(display(), Colors.green[500], Colors.red[500]),
                        enabledBorder: colorBorder(display(), Colors.green[500], Colors.red[500]),
                        disabledBorder: colorBorder(display(), Colors.green[500], Colors.red[500]),
                        focusedBorder: colorBorder(display(), Colors.green[500], Colors.red[500]),
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
            //list1
            renderList(true),
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
            //list 2
            renderList(false),
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