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

  save(Task task) async {
    print('Inside save');
    final Database db = await getDatabase();
    var itemExists = await find(task.nome);
    if (itemExists.isEmpty) {
      print('Task exists = false');
      return await db.insert(_tablename, toMap(task));
    } else {
      print('Task exists = true');
      return await db.update(_tablename, toMap(task),
          where: '$_name = ?', whereArgs: [task.nome]);
    }
  }

  Future<List<Task>> findAll() async {
    print('Inside findAll()');
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tablename);
    print('Fetching data...found: $result');
    return fromMap(result);
  }

  Map<String, dynamic> toMap(Task task) {
    print('Inside toMap(..)');
    final Map<String, dynamic> map = <String, dynamic>{};
    map[_name] = task.nome;
    map[_image] = task.foto;
    map[_difficulty] = task.dificuldade;
    print('New map: $map');
    return map;
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

  delete(String taskName) async {
    print('Deleting task: $taskName');
    final Database db = await getDatabase();
    return await db
        .delete(_tablename, where: '$_name = ?', whereArgs: [taskName]);
  }
}
