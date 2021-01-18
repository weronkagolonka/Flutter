class Unit {
  String name;
  double height, width, length;
  int id;

  Unit(String name, double height, double width, double length) {
    this.name = name;
    this.height = height;
    this.width = width;
    this.length = length;
  }

  Unit.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.name = map["name"];
    this.height = map["height"];
    this.width = map["width"];
    this.length = map["length"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["id"] = this.id;
    map["name"] = this.name;
    map["height"] = this.height;
    map["width"] = this.width;
    map["length"] = this.length;

    return map;
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
