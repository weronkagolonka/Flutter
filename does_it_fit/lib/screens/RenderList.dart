import 'package:flutter/material.dart';
import './DisplayCalc.dart';
import '../main.dart';

class RenderList extends StatelessWidget {

  Widget build(BuildContext context) {
  return ListView.builder(
      itemCount: ctrl.getAllUnits().length,
      itemBuilder: (context, index) {
        final item = ctrl.getAllUnits()[index];

        return ListTile(
          title: Text(item.getName()),
          onTap: () {
            setState(() {
              currentUnit1 = item;
            });
          },
        );
      }
      );
  }
}