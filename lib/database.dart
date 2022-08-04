import 'dart:convert';
import 'dart:io';
import 'package:app_tireproduct/datamodel/product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class DatabaseHelpe {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;
  DatabaseHelpe._privateConstructor();
  static final DatabaseHelpe instance = DatabaseHelpe._privateConstructor();
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate th db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  //this opens the database and creates it if it donesn't exist
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    //SQL code to create product table
    await db.execute(
        ''' CREATE TABLE product(pid INTEGER PRIMARY KEY,pname TEXT NOT NULL UNIQUE,)''');
    //SQL code to create product trie table
    await db.execute('''CREATE TABLE procducttire(ptid INTEGER PRIMARY KEY,
      product id INTEGER NOT NULL, ptprice TEXT NOT NULL, ptimage TEXT NOT NULL,
        FOREIGN KEY(product id) REFERENCES product(id) ON DELETE NO ACTION ON UPDATE NO ACTION)''');
  }

  //insert and updating
  Future<Product> upserProduct(Product product) async {
    Database db = await instance.database;
    var count = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT(*) FROM product WHERE pname = ?", [product.pname]));
    if (count == 0) {
      product.pid = await db.insert("product", product.toMap());
    } else {
      await db.update("product", product.toMap(),
          where: "pid = ?", whereArgs: [product.pid]);
    }
    return product;
  }
}
