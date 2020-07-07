import './Unit.dart';

class Dependencies {
  List<Unit> allUnits = new List<Unit>();

  List<Unit> getAllUnits() {
    return allUnits;
  }

  void createUnit(String name, double height, double width, double length) {
    Unit newUnit = new Unit(name, height, width, length);
    allUnits.add(newUnit);
  }

  void removeUnit(int index) {
    if (index < allUnits.length && allUnits.length > 0) {
      allUnits.removeAt(index);
    }
  }

  //return how many of unit1 fit in unit2
  double calculate(int indexUnit1, int indexUnit2, int howmany) {
    //double balance = (allUnits.elementAt(indexUnit2).getValue() / (allUnits.elementAt(indexUnit1).getValue() * howmany));
    double balanceHeight = (allUnits.elementAt(indexUnit2).getHeight() /
            allUnits.elementAt(indexUnit1).getHeight())
        .floorToDouble();
    double balanceWidth = (allUnits.elementAt(indexUnit2).getWidth() /
            allUnits.elementAt(indexUnit1).getWidth())
        .floorToDouble();
    double balanceLength = (allUnits.elementAt(indexUnit2).getLength() /
            allUnits.elementAt(indexUnit1).getLength())
        .floorToDouble();

    //amount of stuff 1 we can fit in stuff 2
    double max = balanceHeight * balanceLength * balanceWidth;

    double balance = max / howmany;

    return balance;
  }

  int howManyUnits() {
    return allUnits.length;
  }
}
