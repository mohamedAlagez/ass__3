import 'package:ass_3/task_model.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static DBHelper dbHelper = DBHelper._();

  static Database database;

  Future<Database> initDatabase() async {
    if (database == null) {
      return await createDatabase();
    } else {
      return database;
    }
  }

  Future<Database> createDatabase() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'task.db');

      Database database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          db.execute(
              'CREATE TABLE task (id INTEGER PRIMARY KEY, name TEXT, isComplete INTEGER)');
        },
      );
      return database;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<Task> addNewTask(Task task) async {
    try {
      database = await initDatabase();
      task.id = await database.insert('task', task.toMap());
      return task;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Task>> getTask() async {
    database = await initDatabase();
    List<Map> maps =
        await database.query('task', columns: ['id', 'name', 'isComplete']);
    List<Task> tasks = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        tasks.add(Task.fromMap(maps[i]));
      }
    }
    return tasks;
  }

  Future<List<Task>> getCompleteTask() async {
    database = await initDatabase();
    List<Map> maps = await database.query('task',
        columns: ['id', 'name', 'isComplete'],
        where: 'isComplete=?',
        whereArgs: [1]);
    List<Task> tasks = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        tasks.add(Task.fromMap(maps[i]));
      }
    }
    return tasks;
  }

  Future<List<Task>> getInCompleteTask() async {
    database = await initDatabase();
    List<Map> maps = await database.query('task',
        columns: ['id', 'name', 'isComplete'],
        where: 'isComplete=?',
        whereArgs: [0]);
    List<Task> tasks = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        tasks.add(Task.fromMap(maps[i]));
      }
    }
    return tasks;
  }

  Future<int> delete(int id) async {
    database = await initDatabase();
    return await database.delete(
      'task',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(Task task) async {
    database = await initDatabase();
    return await database.update(
      'task',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future close() async {
    database = await initDatabase();
    database.close();
  }
}
