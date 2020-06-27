import 'package:meu_app/databases/app_database.dart';
import 'package:meu_app/models/taskmodel.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao{
  static const String createTable = "CREATE TABLE $tableName("
    "$id INTEGER PRIMARY KEY, "
    "$tarefa TEXT,"
    "$dia INTEGER,"
    "$start INTEGER,"
    "$end INTEGER)";
  static const String tableName = "tasks";
  static const String id =  "id";
  static const String tarefa = "tarefa";
  static const String dia = "dia";
  static const String start = "start";
  static const String end = "end";

  Future<int> save(Task task) async {
    final Database db = await createDatabase();
    final Map<String, dynamic> taskMap = Map();
    taskMap[tarefa] = task.tarefa;
    taskMap[dia] = task.dia;
    taskMap[start] = task.start;
    taskMap[end] = task.end;

    return db.insert(tableName, taskMap);

  }

  Future<List<Task>> findAll() async{
    final Database db = await createDatabase();
    final List<Map<String, dynamic>> results = await db.query(tableName);
    final List<Task> tasks = List();


    for(Map<String, dynamic> map in results){
      final Task task = Task(
        map[tarefa],
        map[start],
        map[end],
        id: map[id]
      );

      tasks.add(task);  
    }
    return tasks;
  }


}



