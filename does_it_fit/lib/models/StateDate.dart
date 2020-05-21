import 'package:does_it_fit/models/Dependencies.dart';
import 'Unit.dart';

class StateData {
  Dependencies unitList;
  Unit currentUnit1;
  Unit currentUnit2;

  StateData() {
    unitList = Dependencies();
    fillList();
    setCurrUnit(unitList.getAllUnits()[0], true);
    setCurrUnit(unitList.getAllUnits()[0], false);
  }

  void fillList() {
    unitList.createUnit('beer', 16.8, 6.33, 6.33);
    unitList.createUnit('30l bag', 44, 21, 30);
    unitList.createUnit('Pidgeon\'s feather', 16, 0.5, 2);
    unitList.createUnit('Fridge', 100, 65, 60);
    unitList.createUnit('Saturn V', 10966.704, 1005.84, 1005.84);
    unitList.createUnit('Fiat Multipla', 167, 187.1, 399.4);
    unitList.createUnit('Potato chip', 4, 0.2, 3);
    unitList.createUnit('Rice grain', 0.7, 0.3, 0.3);
    unitList.createUnit('Big box', 24, 40, 56);
    unitList.createUnit('Small box', 6, 4, 7);
  }

  void setCurrUnit(Unit unit, bool isFirst) {
    if (isFirst)
      currentUnit1 = unit;
    else
      currentUnit2 = unit;
  }

  List<Unit> getUnits() {
    return unitList.getAllUnits();
  }
}
