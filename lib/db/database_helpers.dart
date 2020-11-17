import 'dart:io';
import 'package:flutter_to_do_list/model/todo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableName = 'todoList';

class DBHelper {
  DBHelper._();

  static final DBHelper db = DBHelper._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo.db');

    // Delete the database
    // await deleteDatabase(path);

    // 데이터베이스를 열고 참조 값을 얻습니다.
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // 데이터베이스에 CREATE TABLE 수행
        await db.execute(
            "CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, date TEXT)");
      },
    );
  }
  // CREATE
  insertTodo(Todo todo) async {
    final db = await database;
    var res = await db.insert(tableName, todo.toJson());
    return res;
  }

  // READ
  getTodo(int id) async {
    final db = await database;
    var res = await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Todo.fromJson(res.first) : Null;
  }

  // READ ALL DATA
  getAllTodos() async {
    final db = await database;
    var res = await db.query(tableName);
    List<Todo> list =
    res.isNotEmpty ? res.map((c) => Todo.fromJson(c)).toList() : [];
    return list;
  }

  // Update Todo
  updateTodo(Todo todo) async {
    final db = await database;
    var res = await db.update(tableName, todo.toJson(),
        where: 'id = ?', whereArgs: [todo.id]);
    return res;
  }

  // Delete Todo
  deleteTodo(int id) async {
    final db = await database;
    db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  // Delete All Todos
  deleteAllTodos() async {
    final db = await database;
    db.rawDelete('DELETE FROM $tableName');
  }
}
