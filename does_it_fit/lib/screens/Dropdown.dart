import 'package:does_it_fit/main.dart';
import 'package:does_it_fit/models/Dependencies.dart';
import 'package:does_it_fit/models/StateDate.dart';
import 'package:does_it_fit/models/Unit.dart';
import 'package:does_it_fit/screens/DisplayCalc.dart';
import 'package:does_it_fit/screens/EditItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AddItem.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../colors.dart' as colors;

//refactorize - one body widget for both lists
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
        title: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'I wanna fit...',
            overflow: TextOverflow.ellipsis,
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
                    size: mainHeight * 0.05, color: Colors.grey),
                onPressed: () => Navigator.pop(context)),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: RenderList(
          isFirst: true,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        notchMargin: 8,
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(
              horizontal: mainHeight * 0.02, vertical: mainHeight * 0.02),
          child: FlatButton(
            onPressed: () {
              //additem()
              //Navigator.pop(context);
              Navigator.of(context).push(newRoute(AddItem()));
            },
            child: Text(
              'add new',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: mainHeight * 0.05,
                  fontWeight: FontWeight.bold),
            ),
            color: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            padding: EdgeInsets.all(mainHeight * 0.015),
          ),
        ),
      ),
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
        title: Container(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Container(
                  child: FlatButton(
                    padding:
                        EdgeInsets.only(left: 0, right: mainHeight * 0.015),
                    //UnitList
                    onPressed: () =>
                        Navigator.of(context).push(newRoute(UnitList())),
                    child: Text(
                      '${data.currentUnit1.getName()}s',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        decorationStyle: TextDecorationStyle.solid,
                        color: Colors.black,
                        fontSize: mainHeight * 0.05,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  'in a...',
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: mainHeight * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: mainHeight * 0.02),
            child: IconButton(
                icon: Icon(Icons.clear,
                    size: mainHeight * 0.05, color: Colors.grey),
                onPressed: () => Navigator.pop(context)),
          ),
        ],
      ),
      body: RenderList(
        isFirst: false,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        notchMargin: 8,
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: mainHeight * 0.02, vertical: mainHeight * 0.02),
          child: FlatButton(
            onPressed: () {
              //AddItem
              Navigator.of(context).push(newRoute(AddItem()));
            },
            child: Text(
              'add new',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: mainHeight * 0.05,
                  fontWeight: FontWeight.bold),
            ),
            color: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            padding: EdgeInsets.all(mainHeight * 0.015),
          ),
        ),
      ),
    );
  }
}

class RenderList extends StatefulWidget {
  final bool isFirst;

  RenderList({@required this.isFirst});

  _RenderList createState() => _RenderList();
}

class _RenderList extends State<RenderList> {
  Widget build(BuildContext context) {
    Dependencies database = Dependencies.instance;
    List<Unit> toRender = new List<Unit>();
    ScrollController listCtrl = new ScrollController();
    double mainHeight = MediaQuery.of(context).size.height;

    return FutureBuilder(
        future: database.listAll(),
        builder: (context, snapshot) {
          toRender = snapshot.data;

          if (snapshot.hasData) {
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

                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Container(
                      color: Colors.white,
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: mainHeight * 0.01,
                            horizontal: mainHeight * 0.02),
                        title: Text(
                          item.getName(),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: mainHeight * 0.04),
                        ),
                        onTap: () {
                          setState(() {
                            if (widget.isFirst) {
                              data.currentUnit1 = item;
                            } else {
                              data.currentUnit2 = item;
                            }
                            Navigator.pushReplacement(
                                context, newRoute(DisplayCalc()));
                          });
                        },
                      ),
                    ),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        color: colors.GREEN_SECUNDARY,
                        caption: 'edit',
                        icon: Icons.edit,
                        onTap: () {
                          Navigator.push(
                                  context, newRoute(EditItem(unit: item)))
                              .then((value) => setState(() {}));
                        },
                      ),
                      IconSlideAction(
                        color: colors.RED_PRIMARY,
                        caption: 'delete',
                        icon: Icons.delete,
                        onTap: () {
                          setState(() {
                            if (data.currentUnit1.id == item.id) {
                              if (index > 0) {
                                data.currentUnit1 = toRender[index - 1];
                              } else {
                                data.currentUnit1 = toRender[index + 1];
                              }
                            }

                            if (data.currentUnit2.id == item.id) {
                              if (index > 0) {
                                data.currentUnit2 = toRender[index - 1];
                              } else {
                                data.currentUnit2 = toRender[index + 1];
                              }
                            }

                            database.delete(item);
                            toRender.remove(item);
                          });
                        },
                      ),
                    ],
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
