import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart';
import 'package:meu_app/databases/app_database.dart';
import 'package:meu_app/databases/task_dao.dart';
import 'package:meu_app/models/taskmodel.dart';
import 'package:intl/intl.dart';

class TelaTask extends StatefulWidget {
  static final String ID = "task";
  TelaTask({Key key}) : super(key: key);

  @override
  _TelaTaskState createState() => _TelaTaskState();
}

class _TelaTaskState extends State<TelaTask> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final TaskDao _taskDao = TaskDao();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _constroiTelaTask();
  }

  Widget _constroiTelaTask() {
    return Scaffold(
      body: _constroiBodyTask(),
      appBar: _constroiAppBarTask(),
    );
  }

  _constroiAppBarTask() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 190, 185, 199),
      title: Text(
        "Adicionar Tarefa",
        style: TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  _constroiBodyTask() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          TextField(
            //nome da task
            controller: _nameController,
            decoration: InputDecoration(labelText: "Tarefa"),
          ),
          TextField(
            //inicio da task
            controller: _startController,
            decoration: InputDecoration(labelText: "Início"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            //final da task
            controller: _endController,
            decoration: InputDecoration(labelText: "Final"),
            keyboardType: TextInputType.number,
          ),
          /*
          Row(
            children: <Widget>[
              SizedBox(
                //width: double.infinity,
                child: RaisedButton(
                    onPressed: () {}, child: Text("inicio")),
              ),
              SizedBox(
                //width: double.infinity,
                child: RaisedButton(
                    onPressed: () {}, child: Text("fim")),
              ),
            ],
          ),*/
          SizedBox(
            width: double.maxFinite,
            child: RaisedButton(
                onPressed: () {
                  setState(() {
                    final Task task = Task(
                      _nameController.text ?? "",
                      int.tryParse(_startController.text) ?? "",
                      int.tryParse(_endController.text) ?? "",
                    );

                    Navigator.of(context).pop(_taskDao.save(task));
                  });
                },
                /*
                onPressed: () async {
                  final String tarefa = _nameController.text;
                  final int start = int.tryParse(_startController.text);
                  final int end = int.tryParse(_endController.text);
                  if (tarefa != null && start != null && end != null) {
                    final Task task = Task(tarefa, start, end);
                    int id = await save(task);
                    Navigator.of(context).pop(_taskDao.save(task));
                  }
                },*/
                child: Text("adicionar")),
          ),
        ],
      ),
    );
  }
}
