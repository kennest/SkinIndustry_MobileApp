import 'dart:async';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:mobile_ecommerce/floordb/dao/userDao.dart';
import 'package:mobile_ecommerce/floordb/dao/categoryDao.dart';
import 'package:mobile_ecommerce/floordb/dao/productDao.dart';
import 'package:mobile_ecommerce/floordb/models/category.dart';
import 'package:mobile_ecommerce/floordb/models/product.dart';
import 'package:mobile_ecommerce/floordb/models/user.dart';


part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [User,Product,Category])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
  ProductDao get productDao;
  CategoryDao get categoryDao;
}