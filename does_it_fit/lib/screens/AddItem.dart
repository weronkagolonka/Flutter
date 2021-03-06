import 'package:does_it_fit/models/Dependencies.dart';
import 'package:does_it_fit/models/Unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';
import './Splashscreen.dart';

class AddItem extends StatefulWidget {
  _AddItem createState() => _AddItem();
}

class _AddItem extends State<AddItem> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController addController,
      addController2,
      addController3,
      addController4;
  FocusNode myFocus1 = FocusNode();
  FocusNode myFocus2 = FocusNode();
  FocusNode myFocus3 = FocusNode();
  FocusNode myFocus4 = FocusNode();
  bool text1, hasChanged1, hasChanged2, hasChanged3, hasChanged4;
  double length;
  double height;
  double depth;
  String name;

  @override
  void dispose() {
    addController.dispose();
    addController2.dispose();
    addController3.dispose();
    addController4.dispose();
    super.dispose();
  }

  @override
  initState() {
    addController = TextEditingController();
    addController2 = TextEditingController();
    addController3 = TextEditingController();
    addController4 = TextEditingController();
    text1 = false;
    hasChanged1 = false;
    hasChanged1 = false;
    hasChanged1 = false;
    hasChanged1 = false;
    super.initState();
  }

  bool isOk(bool key1, bool key2, bool key3, bool key4) {
    if (key1 && key2 && key3 && key4)
      return true;
    else
      return false;
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'I wanna add...',
              style: TextStyle(
                  fontSize: mainHeight * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: mainHeight * 0.02),
              child: IconButton(
                  icon: Icon(Icons.clear,
                      color: Colors.grey, size: mainHeight * 0.05),
                  onPressed: () => Navigator.pop(context)),
            ),
          ],
        ),
        body: Container(
          color: Colors.white,
          child: addItem(mainHeight, mainWidth),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          notchMargin: 8,
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: mainHeight * 0.02, vertical: mainHeight * 0.02),
            child: FlatButton(
              onPressed: text1
                  ? () => filledFormBtn(length, height, depth, name)
                  : null,
              color: Colors.black,
              disabledColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              padding: EdgeInsets.all(mainHeight * 0.015),
              child: Text(
                'add',
                style: TextStyle(
                  fontSize: mainHeight * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //1 - length, 2 - height, 3 - depth
  Widget setForm(String hintText, bool isNumeric, int queue, bool changed,
      TextEditingController controller, FocusNode focus, double mainHeight) {
    if (isNumeric) {
      return TextFormField(
        validator: (value) {
          if (value.isEmpty || int.parse(value) == 0)
            return '';
          else
            return null;
        },
        style: TextStyle(
          fontSize: mainHeight * 0.04,
        ),
        controller: controller,
        focusNode: focus,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          errorText: null,
          errorStyle: TextStyle(height: 0),
          contentPadding: EdgeInsets.all(mainHeight * 0.02),
          hintText: hintText,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(200)),
            borderSide: BorderSide(
                color: Colors.red[500], width: 5, style: BorderStyle.solid),
            gapPadding: mainHeight * 0.015,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(200)),
            borderSide: BorderSide(
                color: Colors.grey[300], width: 1, style: BorderStyle.solid),
            gapPadding: mainHeight * 0.015,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(200)),
            borderSide: BorderSide(
                color: Colors.grey[300], width: 1, style: BorderStyle.solid),
            gapPadding: mainHeight * 0.015,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(200)),
            borderSide: BorderSide(
                color: Colors.red[500], width: 5, style: BorderStyle.solid),
            gapPadding: mainHeight * 0.015,
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
            }
          });
        },
      );
    } else {
      return TextFormField(
        validator: (value) {
          if (value.isEmpty) return '';
          return null;
        },
        style: TextStyle(
          fontSize: mainHeight * 0.04,
        ),
        controller: controller,
        focusNode: focus,
        decoration: InputDecoration(
          //helperText: ' ',
          errorText: null,
          errorStyle: TextStyle(height: 0),
          contentPadding: EdgeInsets.all(mainHeight * 0.02),
          hintText: hintText,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(200)),
            borderSide: BorderSide(
                color: Colors.red[500], width: 5, style: BorderStyle.solid),
            gapPadding: mainHeight * 0.015,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(200)),
            borderSide: BorderSide(
                color: Colors.grey[300], width: 1, style: BorderStyle.solid),
            gapPadding: mainHeight * 0.015,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(200)),
            borderSide: BorderSide(
                color: Colors.grey[100], width: 1, style: BorderStyle.solid),
            gapPadding: mainHeight * 0.015,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(200)),
            borderSide: BorderSide(
                color: Colors.red[500], width: 5, style: BorderStyle.solid),
            gapPadding: mainHeight * 0.015,
          ),
        ),
        onChanged: (String input) {
          setState(() {
            if (input != '' && queue == 0) {
              name = input;
            }
          });
        },
      );
    }
  }

  Widget setSubtitle(String data, double mainHeight) {
    return Text(
      data,
      style: TextStyle(
        fontSize: mainHeight * 0.04,
      ),
    );
  }

  Widget setUnit(double mainHeight) {
    return Container(
      //padding: EdgeInsets.only(left: mainHeight*0.02),
      alignment: Alignment.centerRight,
      child: Text(
        'cm,',
        style: TextStyle(
          fontSize: mainHeight * 0.04,
        ),
      ),
    );
  }

  Widget addItem(double mainHeight, double mainWidth) {
    return ListView(
      controller: ScrollController(),
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: mainHeight * 0.02),
          //constraints: BoxConstraints.tightForFinite(),
          color: Colors.white,
          child: Form(
            key: _formKey,
            onChanged: () {
              setState(() {
                if (addController.text != '' &&
                    addController2.text != '' &&
                    addController3.text != '' &&
                    addController4.text != '') {
                  text1 = true;
                } else
                  text1 = false;
              });
            },
            //autovalidate: true,
            child: Container(
              width: mainWidth,
              height: mainHeight * 0.6,
              margin: EdgeInsets.only(top: mainHeight * 0.02),
              //color: Colors.red,
              //constraints: BoxConstraints(maxHeight: mainHeight, maxWidth: mainWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      //color: Colors.yellow,
                      child: setForm('item name', false, 0, hasChanged1,
                          addController, myFocus1, mainHeight),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      //color: Colors.amber,
                      child: setSubtitle('with a length of...', mainHeight),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      //color: Colors.yellow,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: setForm('eg. 666', true, 1, hasChanged2,
                                addController2, myFocus2, mainHeight),
                          ),
                          Expanded(
                            child: setUnit(mainHeight),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      //color: Colors.amber,
                      alignment: Alignment.centerLeft,
                      child: setSubtitle('height of...', mainHeight),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      //color: Colors.yellow,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: setForm('eg. 1337', true, 2, hasChanged3,
                                addController3, myFocus3, mainHeight),
                          ),
                          Expanded(
                            child: setUnit(mainHeight),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      //color: Colors.amber,
                      alignment: Alignment.centerLeft,
                      child: setSubtitle('and depth of...', mainHeight),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      //color: Colors.yellow,
                      child: Row(
                        children: <Widget>[
                          //to do: ALLOW DECIMALS
                          Expanded(
                            flex: 4,
                            child: setForm('eg. 69', true, 3, hasChanged4,
                                addController4, myFocus4, mainHeight),
                          ),
                          Expanded(
                            child: setUnit(mainHeight),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  filledFormBtn(double length, double height, double depth, String name) async {
    Dependencies database = Dependencies.instance;
    if (_formKey.currentState.validate()) {
      Unit unit = Unit(name, height, depth, length);
      await database.insert(unit);
      //data.unitList.createUnit(name, height, depth, length);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => SplashScreen()));
      //_controller.close();
      addController.clear();
      addController2.clear();
      addController3.clear();
      addController4.clear();
    }
  }
}
