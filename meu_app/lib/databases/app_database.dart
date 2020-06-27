import 'package:meu_app/databases/task_dao.dart';
import 'package:meu_app/models/taskmodel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


Future<Database> createDatabase() async{
  final String dbPath = await getDatabasesPath();
  final String path = join (dbPath, "tasks2_bank.db");
  return openDatabase(path,
    onCreate: (db, version){
      db.execute(TaskDao.createTable);
    },
    version: 1,        
  );
}