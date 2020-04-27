class Unit {

  String name;
  double height, width, length;

  Unit(String name, double height, double width, double length) {
    this.name = name;
    this.height = height;
    this.width = width;
    this.length = length;
  }

  String getName() {
    return this.name;
  }

  double getHeight() {
    return this.height;
  }

  double getWidth() {
    return this.width;
  }

  double getLength() {
    return this.length;
  }
}