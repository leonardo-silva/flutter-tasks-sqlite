import 'package:nosso_primeiro_projeto/components/task.dart';
import 'package:nosso_primeiro_projeto/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT, '
      ')';

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task task) async {}
  Future<List<Task>> findAll() async {
    print('Inside findAll()');
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tablename);
    print('Fetching data...found: $result');
    return fromMap(result);
  }

  List<Task> fromMap(List<Map<String, dynamic>> map) {
    print('Inside fromMap(..)');
    final List<Task> tasks = [];
    for (var element in map) {
      final Task task =
          Task(element[_name], element[_image], element[_difficulty]);
      tasks.add(task);
    }
    print('Tasks list: $tasks');
    return tasks;
  }

  Future<List<Task>> find(String taskName) async {
    print('Inside find()');
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
        await db.query(_tablename, where: '$_name = ?', whereArgs: [taskName]);
    print('Fetching specific data...found: $result');
    return fromMap(result);
  }

  delete(String taskName) async {}
}
