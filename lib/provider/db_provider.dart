import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/todo_model.dart';


class DBProvider{
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database!;

    // If database don't exists, create one
    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async{
    String path = await getDatabasesPath();
    return openDatabase(

      join(path, "Todos.db"),
      onCreate: (database, version) async{
        version:1;
        await database.execute(
          """
          CREATE TABLE Todos(
          id INTEGER PRIMARY KEY,
          userId INTEGER,
          title TEXT,
          completed BOOLEAN
          )
          """,
        );
      }
    );
  }

  Future<bool> insertDB(TodoModel data)async{
    final Database db = await initDB();
    db.insert("Todos", data.toMap());
    return true;
  }

  Future<List<TodoModel>> getAllTodos() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM TODO");

    List<TodoModel> list =
    res.isNotEmpty ? res.map((c) => TodoModel.fromMap(c)).toList() : [];

    return list;
  }
}