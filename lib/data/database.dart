import 'package:nosso_primeiro_projeto/data/task_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'task.db');

  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      print('Inside onCreate()');
      await db.execute(TaskDao.tableSql);
    },
  );
}
