import 'package:does_it_fit/screens/DisplayCalc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './Dropdown.dart';
import '../models/Unit.dart';
import '../models/Dependencies.dart';
import './home.dart';
import '../main.dart';
import './Splashscreen.dart';

class AddItem extends StatefulWidget {
  _AddItem createState() => _AddItem();
}

class _AddItem extends State<AddItem> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState> _formKey1 = GlobalKey<FormFieldState>();
  static final GlobalKey<FormFieldState> _formKey2 = GlobalKey<FormFieldState>();
  static final GlobalKey<FormFieldState> _formKey3 = GlobalKey<FormFieldState>();
  static final GlobalKey<FormFieldState> _formKey4 = GlobalKey<FormFieldState>();
  TextEditingController addController, addController2, addController3, addController4;
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
    text1=false;
    hasChanged1 = false;
    hasChanged1 = false;
    hasChanged1 = false;
    hasChanged1 = false;
    super.initState();
  }

  bool isOk(bool key1, bool key2, bool key3, bool key4) {
    if (key1 && key2 && key3 && key4) return true;
    else return false;
  }
  

  Widget build(BuildContext context) {
    double mainHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
              'I wanna add...',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear, color: Colors.grey, size: 42), 
            onPressed: () => Navigator.pop(context)),
        ],
      ),
      body: addItem(mainHeight),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(10),
          child: FlatButton(
            onPressed: text1 ? () => filledFormBtn(length, height, depth, name) : null, 
            color: Colors.black,
            disabledColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(200)),
            ),
            child: Text(
              'add',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

    //1 - length, 2 - height, 3 - depth
  Widget setForm(String hintText, bool isNumeric, int queue, bool changed, TextEditingController controller, FocusNode focus, double mainHeight) {
    if (isNumeric) {
      return TextFormField(
          validator: (value) {
            if (value.isEmpty || int.parse(value) == 0) return '';
            else return null;
          },
          style: TextStyle(
            fontSize: mainHeight*0.05,
          ),
          controller: controller,
          focusNode: focus,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly,],
          decoration: InputDecoration(
            errorText: null,
            errorStyle: TextStyle(height: 0),
            contentPadding: EdgeInsets.all(10),
            hintText: hintText,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(200)),
              borderSide: BorderSide(color: Colors.red[500], width: 5, style: BorderStyle.solid),
              gapPadding: 15,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(200)),
              borderSide: BorderSide(color: Colors.grey[300], width: 1, style: BorderStyle.solid),
              gapPadding: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(200)),
              borderSide: BorderSide(color: Colors.grey[300], width: 1, style: BorderStyle.solid),
              gapPadding: 15,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(200)),
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
            fontSize: mainHeight*0.05,
          ),
          controller: controller,
          focusNode: focus,
          decoration: InputDecoration(
            //helperText: ' ',
            errorText: null,
            errorStyle: TextStyle(height: 0),
            contentPadding: EdgeInsets.all(10),
            hintText: hintText,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(200)),
              borderSide: BorderSide(color: Colors.red[500], width: 5, style: BorderStyle.solid),
              gapPadding: 15,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(200)),
              borderSide: BorderSide(color: Colors.grey[300], width: 1, style: BorderStyle.solid),
              gapPadding: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(200)),
              borderSide: BorderSide(color: Colors.grey[300], width: 1, style: BorderStyle.solid),
              gapPadding: 15,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(200)),
              borderSide: BorderSide(color: Colors.red[500], width: 5, style: BorderStyle.solid),
              gapPadding: 15,
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
        fontSize: mainHeight*0.05,
      ),
    );
  }

  Widget setUnit(double mainHeight) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Text(
          'cm,',
          style: TextStyle(
            fontSize: mainHeight*0.05,
          ),
        ),
      );
  }

  Widget addItem(double mainHeight) {
    return ListView(
      controller: ScrollController(),
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          //constraints: BoxConstraints.tightForFinite(),
          color: Colors.white,
          child: Form(
            key: _formKey,
            onChanged: () {
              setState(() {
                if (addController.text != '' && addController2.text != '' 
                && addController3.text != '' && addController4.text != '') {
                   text1 = true;
                }
                else text1 = false;
              });
            },
            //autovalidate: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                setForm('item name', false, 0, hasChanged1, addController, myFocus1, mainHeight),
                setSubtitle('with a length of...', mainHeight),
                  //width: 500,
                Row(
                  children: <Widget>[
                    Expanded(
                      child: setForm('eg. 666', true, 1, hasChanged2, addController2, myFocus2, mainHeight),
                    ),
                    setUnit(mainHeight),
                  ],
                ),
                setSubtitle('height of...', mainHeight),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: setForm('eg. 1337', true, 2, hasChanged3, addController3, myFocus3, mainHeight),
                    ),
                    setUnit(mainHeight),
                  ],
                ),
                setSubtitle('and depth of...', mainHeight),
                Row(
                  children: <Widget>[
                    //to do: ALLOW DECIMALS
                    Expanded(
                      child: setForm('eg. 69', true, 3, hasChanged4, addController4, myFocus4, mainHeight),
                    ),
                    setUnit(mainHeight),
                  ],
                ),
              ],
          ),
          ),
          ),
      ],
    );
  }

  filledFormBtn(double length, double height, double depth, String name) {
    if (_formKey.currentState.validate()) {
      ctrl.createUnit(name, height, depth, length);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SplashScreen()));
      //_controller.close();
      addController.clear();
      addController2.clear();
      addController3.clear();
      addController4.clear();
    }
  }
}
 