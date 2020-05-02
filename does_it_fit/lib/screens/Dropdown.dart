//import 'package:does_it_fit/models/Dependencies.dart';
import 'dart:async';

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
      body: Container(
        color: Colors.white,
        child: renderList(mainHeight),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        notchMargin: 8,
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: mainHeight*0.02),
          child: FlatButton(
            onPressed: () {
              //additem()
              //Navigator.pop(context);
              Navigator.of(context).push(newRoute(AddItem()));
            }, 
            child: Text(
              'add new', 
              style: TextStyle(
                color: Colors.white, 
                fontSize: mainHeight*0.05, 
                fontWeight: FontWeight.bold
              ),
            ),
            color: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
            padding: EdgeInsets.all(mainHeight*0.015),
            ),
        ),
      ),
    );
  }


  Widget renderList(double mainHeight) {
    //String value;
    //Unit curr;
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

        return Container(
          color: Colors.white,
          child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: mainHeight*0.01, horizontal: mainHeight*0.027),
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
          ),
        );
      }
    );
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
                  //UnitList
                  onPressed: () => Navigator.of(context).push(newRoute(UnitList())), 
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
          margin: EdgeInsets.symmetric(horizontal: mainHeight*0.02),
          child: FlatButton(
            onPressed: () {
              //AddItem
              Navigator.of(context).push(newRoute(AddItem()));
            }, 
            child: Text('add new', style: TextStyle(color: Colors.white, fontSize: mainHeight*0.05, fontWeight: FontWeight.bold),),
            color: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
            padding: EdgeInsets.all(mainHeight*0.015),
            ),
        ),
      ),
    );
  }


  Widget renderList(double mainHeight) {
    //String value;
    //Unit curr;
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

        return Container(
          color: Colors.white,
          child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: mainHeight*0.01, horizontal: mainHeight*0.027),
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
          ),
        );
      }
    );
  }
}

