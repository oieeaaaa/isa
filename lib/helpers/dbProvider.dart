import 'dart:async';
import 'dart:io';

import 'package:isa/models/Item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  // =========================================================================
  // SINGLETON
  // =========================================================================
  static final DBProvider _dbProvider = DBProvider._internal();
  static Database _db;

  DBProvider._internal();

  factory DBProvider() {
    return _dbProvider;
  }

  // =========================================================================
  // GETTERS
  // =========================================================================

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDB();
    }

    return _db;
  }

  // =========================================================================
  // ITEM TABLE
  // =========================================================================
  String tableName = 'item';

  // =========================================================================
  // ITEM TABLE COLUMNS
  // =========================================================================

  // item details
  String id = 'id';
  String name = 'name';
  String price = 'price';
  String imageUrl = 'imageUrl';
  String quantity = 'quantity';

  // customer information
  String customerName = 'customerName';
  String customerContactNumber = 'customerContactNumber';

  // miscellaneous
  String notes = 'notes';
  String createdAt = 'createdAt';

  // =========================================================================
  // INIT DB
  // =========================================================================

  Future<Database> initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'isa.db';

    var dbISA = await openDatabase(path, version: 1, onCreate: _onCreate);

    return dbISA;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('''
        create table $tableName(
          $id integer primary key, 
          $name text not null, 
          $price decimal, 
          $imageUrl text, 
          $quantity decimal, 
          $customerName text, 
          $customerContactNumber text, 
          $notes text, 
          $createdAt text
        )''');
  }

  // =========================================================================
  // !!! QUERY METHODS HERE !!!
  // =========================================================================

  // add item
  Future<int> insertItem(Item item) async {
    Database db = await this.db;

    var result = await db.insert(tableName, item.toMap());

    return result;
  }

  // get items
  Future<List> getItems(List<DateTime> range) async {
    Database db = await this.db;
    String startDate = range[0].toString();
    String endDate = range[0].toString();

    List<Map<String, dynamic>> result = await db.query(
      tableName,
      where: '$createdAt >= ? and ? <= ?',
      whereArgs: [startDate, startDate, endDate],
      orderBy: 'createdAt asc',
    );

    return result;
  }

  // get one item
  Future getItem(int itemId) async {
    Database db = await this.db;

    var result = await db.query(
      tableName,
      where: '$id = ?',
      whereArgs: [itemId],
    );

    return result[0];
  }

  // update item
  Future<int> updateItem(Item item) async {
    Database db = await this.db;

    var itemResult = await this.getItem(item.id);

    var result = await db.update(
        tableName,
        {
          ...item.toMap(),
          'createdAt': itemResult['createdAt'],
        },
        where: '$id = ?',
        whereArgs: [item.id]);

    return result;
  }

  // delete item
  Future<int> deleteItem(int itemId) async {
    Database db = await this.db;

    var result =
        await db.delete(tableName, where: '$id = ?', whereArgs: [itemId]);

    return result;
  }
}
