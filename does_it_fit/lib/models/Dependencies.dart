import './Unit.dart';

class Dependencies {

  List<Unit> allUnits = new List<Unit>();

  List<Unit> getAllUnits() {
    return allUnits;
  }

  void createUnit(String name, double volume, {int min, int max}) {
    Unit newUnit = new Unit(name, volume);
    allUnits.add(newUnit);
  }

  void removeUnit(int index) {
    if (index < allUnits.length) {
      allUnits.removeAt(index);
    }
  }

  //return how many of unit1 fit in unit2
  double calculate(int indexUnit1, int indexUnit2, int howmany) {

    double balance = (allUnits.elementAt(indexUnit2).getValue() / (allUnits.elementAt(indexUnit1).getValue() * howmany));

    return balance;
  } 

  int howManyUnits() {
    return allUnits.length;
  }
  
}