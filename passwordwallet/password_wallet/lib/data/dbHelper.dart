import 'dart:async';

import 'package:password_wallet/models/password.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DbHelper {
  Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "PasswordWallet");
    var passwordWalletDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return passwordWalletDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table wallet(id integer primary key,platformName text,userName text,password text)");
  }

  Future<List<Password>> getPassword() async{
    Database db = await this.db;
    var result = await db.query("wallet");
    return List.generate(result.length, (i){
      return Password.fromObject(result[i]);
    });

  }

  Future<int> insert(Password password) async{
    Database db = await this.db;
    var result = await db.insert("wallet", password.toMap());
  }

  Future<int> delete(int id) async{
    Database db = await this.db;
    var result = await db.rawDelete("delete from wallet where id=$id");
    return result;
  }
  Future<int> update(Password password) async{
    Database db = await this.db;
    var result = await db.update("wallet", password.toMap(),where: "id=?",whereArgs: [password.id]);
    return result;
  }

}