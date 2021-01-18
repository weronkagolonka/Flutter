import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import './Unit.dart';

// database table and column names
final String tableUnit = 'units';
final String name = 'name';
final String height = 'height';
final String width = 'width';
final String length = 'length';

class Dependencies {
  static final _databaseName = "Units.db";
  static final _databaseVersion = 1;

  Dependencies._privateConstructor();
  static final Dependencies instance = Dependencies._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

// open the database
  _initDatabase() async {
    print("initialize");
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + _databaseName;
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  /*
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
  */

  Future _onUpgrade(Database db, int version, int newVersion) async {
    await db.execute('''
      DROP TABLE $tableUnit
    ''');
    await _onCreate(db, newVersion);
  }

  Future _onCreate(Database db, int version) async {
    print("create");
    await db.execute('''
              CREATE TABLE $tableUnit (
                id INTEGER PRIMARY KEY,
                $name TEXT NOT NULL,
                $height DOUBLE NOT NULL,
                $width DOUBLE NOT NULL,
                $length DOUBLE NOT NULL
              )
              ''');

    await db.execute('''
      INSERT INTO $tableUnit (
        name, 
        height, 
        width, 
        length
      ) VALUES (
        'beer',
        16.8,
        6.33,
        6.33
      ),
      (
        '30l bag',
        44,
        21,
        30
      ),
      (
        'Fridge',
        100,
        65,
        60
      ),
      (
        'Saturn V',
        10966.704,
        1005.84,
        1005.84
      ),
      (
        'Fiat Multipla',
        167,
        187.1,
        399.4
      ),
      (
        'Potato chip',
        4,
        0.2,
        3
      ),
      (
        'Rice grain',
        0.7,
        0.3,
        0.3
      )
    ''');
  }

  Future<int> insert(Unit unit) async {
    Database db = await database;
    int id = await db.insert(tableUnit, unit.toMap());
    return id;
  }

  Future<int> delete(Unit unit) async {
    Database db = await database;
    return db.delete(tableUnit, where: 'id = ?', whereArgs: [unit.id]);
  }

  Future<int> update(Unit updatedUnit) async {
    Database db = await database;
    var toMap = updatedUnit.toMap();

    return db
        .update(tableUnit, toMap, where: 'id = ?', whereArgs: [updatedUnit.id]);
  }

  Future<Unit> select(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> unit = await db.query(tableUnit);
    return Unit.fromMap(unit[0]);
  }

  Future<List<Unit>> listAll() async {
    Database db = await database;
    List<Unit> units = List<Unit>();

    List<Map<String, dynamic>> dbUnits = await db.query(tableUnit);

    dbUnits.forEach((unit) => units.add(Unit.fromMap(unit)));

    return units;
  }
/*
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
  */

  //return how many of unit1 fit in unit2
  double calculate(Unit unit1, Unit unit2, int howmany) {
    //double balance = (allUnits.elementAt(indexUnit2).getValue() / (allUnits.elementAt(indexUnit1).getValue() * howmany));
    double balanceHeight =
        (unit2.getHeight() / unit1.getHeight()).floorToDouble();
    double balanceWidth = (unit2.getWidth() / unit1.getWidth()).floorToDouble();
    double balanceLength =
        (unit2.getLength() / unit1.getLength()).floorToDouble();

    //amount of stuff 1 we can fit in stuff 2
    double max = balanceHeight * balanceLength * balanceWidth;

    double balance = max / howmany;

    return balance;
  }
}
