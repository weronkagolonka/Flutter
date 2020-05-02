//import 'package:does_it_fit/models/Dependencies.dart';
import 'package:does_it_fit/screens/DisplayCalc.dart';
import 'package:flutter/material.dart';
import '../models/Unit.dart';
import 'package:does_it_fit/main.dart';
import 'AddItem.dart';

class UnitList extends StatefulWidget {

  _UnitList createState() => _UnitList();
}

class _UnitList extends State<UnitList> {

  Widget build(BuildContext context) {
    double mainHeight = MediaQuery.of(context).size.height;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
            title: Text(
              'I wanna fit...',
              style: TextStyle(
                fontSize: mainHeight*0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.clear, color: Colors.grey, size: mainHeight*0.05), 
                onPressed: () => Navigator.pop(context)),
            ],
          ),
      body: renderList(mainHeight),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        notchMargin: 8,
        child: Container(
          padding: EdgeInsets.all(10),
          child: FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddItem()));
              }, 
            child: Text('add new', style: TextStyle(color: Colors.white, fontSize: mainHeight*0.05, fontWeight: FontWeight.bold),),
            color: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
            padding: EdgeInsets.all(10),
            ),
        ),
      ),
    );
  }


  Widget renderList(double mainHeight) {
    String value;
    Unit curr;
    List toRender = new List();
    ScrollController listCtrl = new ScrollController();

    for(int i=0;i<ctrl.getAllUnits().length;i++) {
      toRender.add(ctrl.getAllUnits()[i]);
    }

    return ListView.separated(
      separatorBuilder: (context, index) {

        return Divider(
          color: Colors.grey,
          height: 1,
        );
      },

      controller: listCtrl,
      shrinkWrap: true,
      itemCount: toRender.length,
      itemBuilder: (context, index) {
        final item = toRender[index];

        return ListTile(
          contentPadding: EdgeInsets.all(mainHeight*0.01),
            title: Text(
              item.getName(),
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: mainHeight*0.04),
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
    );

    /*
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
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          scaffoldKey.currentState.showBottomSheet((context) => 
          Container(
            width: 500,
            height: 800,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: list,
          ),
        );
      }, 
      ),
      );
      */
  }
}

class UnitList2 extends StatefulWidget {
  _UnitList2 createState() => _UnitList2();
}

class _UnitList2 extends State<UnitList2> {

  Widget build(BuildContext context) {
    double mainHeight = MediaQuery.of(context).size.height;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: false,
            elevation: 0,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.only(left: 0, right: 10),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UnitList())), 
                  child: Text(
                    '${dropdownValue1}s',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                      decorationStyle: TextDecorationStyle.solid,
                      color: Colors.black,
                      fontSize: mainHeight*0.05,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  ),
                  Text(
                    'in a...',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: mainHeight*0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                padding: EdgeInsets.only(right: 25),
                icon: Icon(Icons.clear, size: mainHeight*0.05, color: Colors.grey), 
                onPressed: () => Navigator.pop(context)),
            ],
      ),
      body: renderList(mainHeight),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        notchMargin: 8,
        child: Container(
          padding: EdgeInsets.all(10),
          child: FlatButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddItem()));
            }, 
            child: Text('add new', style: TextStyle(color: Colors.white, fontSize: mainHeight*0.05, fontWeight: FontWeight.bold),),
            color: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
            padding: EdgeInsets.all(10),
            ),
        ),
      ),
    );
  }


  Widget renderList(double mainHeight) {
    String value;
    Unit curr;
    List toRender = new List();
    ScrollController listCtrl = new ScrollController();

    for(int i=0;i<ctrl.getAllUnits().length;i++) {
      toRender.add(ctrl.getAllUnits()[i]);
    }

    return ListView.separated(
      separatorBuilder: (context, index) {

        return Divider(
          color: Colors.grey,
          height: 1,
        );
      },

      controller: listCtrl,
      shrinkWrap: true,
      itemCount: toRender.length,
      itemBuilder: (context, index) {
        final item = toRender[index];

        return ListTile(
          contentPadding: EdgeInsets.all(mainHeight*0.01),
          title: Text(
            item.getName(),
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: mainHeight*0.04),
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
    );
  }
}

