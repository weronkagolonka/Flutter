class Unit {

  String name;
  int min, max;
  double volume;

  Unit(String name, double volume, {int min = 1, int max = 100}) {
    this.name = name;
    this.min = min;
    this.max = max;
    this.volume = volume;
  }

  String getName() {
    return this.name;
  }

  int getMin() {
    return this.min;
  }

  int getMax() {
    return this.max;
  }

  double getValue() {
    return this.volume;
  }
}