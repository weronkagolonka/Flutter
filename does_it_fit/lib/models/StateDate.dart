import 'package:does_it_fit/models/Dependencies.dart';
import 'Unit.dart';

class StateData {
  Dependencies unitList = Dependencies.instance;
  Unit currentUnit1;
  Unit currentUnit2;

  Future<void> initializeUnits() async {
    Unit c1 = await unitList.select(0);
    Unit c2 = await unitList.select(1);
    print("done");
    currentUnit1 = c1;
    currentUnit2 = c2;
  }

  void setCurrUnit(Unit unit, bool isFirst) {
    if (isFirst)
      currentUnit1 = unit;
    else
      currentUnit2 = unit;
  }
}
