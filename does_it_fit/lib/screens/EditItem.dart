import 'package:does_it_fit/main.dart';
import 'package:does_it_fit/models/Dependencies.dart';
import 'package:does_it_fit/models/Unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditItem extends StatefulWidget {
  final Unit unit;

  EditItem({@required this.unit});

  _EditItem createState() => _EditItem();
}

class _EditItem extends State<EditItem> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController editingController,
      editingController2,
      editingController3,
      editingController4;
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
    editingController.dispose();
    editingController2.dispose();
    editingController3.dispose();
    editingController4.dispose();

    super.dispose();
  }

  @override
  initState() {
    editingController = TextEditingController();
    editingController.text = widget.unit.name;
    name = widget.unit.name;

    editingController2 = TextEditingController();
    editingController2.text = widget.unit.length.toInt().toString();
    length = widget.unit.length;

    editingController3 = TextEditingController();
    editingController3.text = widget.unit.height.toInt().toString();
    height = widget.unit.height;

    editingController4 = TextEditingController();
    editingController4.text = widget.unit.width.toInt().toString();
    depth = widget.unit.width;

    text1 = false;
    hasChanged1 = false;
    hasChanged1 = false;
    hasChanged1 = false;
    hasChanged1 = false;

    super.initState();
  }

  Widget build(BuildContext context) {
    double mainHeight = MediaQuery.of(context).size.height;
    double mainWidth = MediaQuery.of(context).size.width;
    FocusScopeNode currFocus = FocusScope.of(context);

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
              'I wanna edit...',
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
                'save',
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
                if (editingController.text != '' &&
                    editingController2.text != '' &&
                    editingController3.text != '' &&
                    editingController4.text != '') {
                  text1 = true;
                } else
                  text1 = false;
              });
            },
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
                          editingController, myFocus1, mainHeight),
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
                                editingController2, myFocus2, mainHeight),
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
                                editingController3, myFocus3, mainHeight),
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
                                editingController4, myFocus4, mainHeight),
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
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly,
        ],
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

  filledFormBtn(
    double length,
    double height,
    double depth,
    String name,
  ) async {
    Dependencies database = Dependencies.instance;
    if (_formKey.currentState.validate()) {
      Unit oldUnit = widget.unit;
      print(oldUnit.name);
      setState(() {
        widget.unit.name = name;
        widget.unit.height = height;
        widget.unit.length = length;
        widget.unit.width = depth;

        if (oldUnit.id == data.currentUnit1.id) {
          print("1");
          data.currentUnit1 = widget.unit;
        }

        if (oldUnit.id == data.currentUnit2.id) {
          print("2");

          data.currentUnit2 = widget.unit;
        }
      });

      await database.update(widget.unit);

      Navigator.pop(context);
      editingController.clear();
      editingController2.clear();
      editingController3.clear();
      editingController4.clear();
    }
  }
}
