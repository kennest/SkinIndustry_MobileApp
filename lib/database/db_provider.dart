import 'dart:async';
import 'dart:io';
import 'package:objectdb/objectdb.dart';
import 'package:mobile_ecommerce/models/product.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static final DBProvider _singleton = new DBProvider._internal();

  factory DBProvider() {
    return _singleton;
  }

  DBProvider._internal();

  Future<ObjectDB> initDB() async {
    Directory tempDir = await getExternalStorageDirectory();

//OBJECTDB
    var database = ObjectDB('${tempDir.path}/database.db');
    database.open();

    await database.insertMany([
      {
        "name": {"first": "Maria", "last": "Smith"},
        "age": 20,
        "active": false
      },
      {
        "name": {"first": "James", "last": "Jones"},
        "age": 32,
        "active": false
      },
    ]);

    // find documents
    print(await database.find({
      Op.lte: {"age": 30}
    }));
    
    return database;
  }

  void insertProduct(Product p) async {
    DBProvider().initDB().then((db) {
      db.insert(p.toMap());
    });

    getData();
  }

  void insertmanyProducts(List<Product> products) async {
    DBProvider().initDB().then((db) {
      for (Product p in products) {
        db.insert(p.toMap());
      }
      getData();
    });
  }

  void getData() async {
    DBProvider().initDB().then((db) async {
      var find=await db.find({
        Op.lt: {"price": 1000},
      });
      print('Result found -> ${find.toString()}');
    });
  }
}
