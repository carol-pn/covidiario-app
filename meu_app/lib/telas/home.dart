import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:meu_app/telas/task.dart';
import 'package:meu_app/databases/app_database.dart';
import 'package:meu_app/models/taskmodel.dart';
import 'package:meu_app/databases/task_dao.dart';

class TelaHome extends StatefulWidget {
  @override
  _TelaHomeState createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  
  CalendarController _calendarController;
  

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return _constroiTelaHome();
  }

  Widget _constroiTelaHome() {
    return Scaffold(
      body: _constroiBodyHome(),
      appBar: _constroiAppBarHome(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 190, 185, 199),
        onPressed: () {
          //Navigator.push(
          //    context, MaterialPageRoute(builder: (context) => TelaTask()));
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TelaTask()));
        },
      ),
    );
  }

  _constroiAppBarHome() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 190, 185, 199),
      title: Text(
        "Hoje",
        style: TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  _constroiBodyHome() {
    return Column(
      children: <Widget>[
        Container(
          child: _calendar(_calendarController),
        ),
        //_calendar(_calendarController),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: _listaTarefas(),
        ),
        //_listaTarefas(),
      ],
    );
  }
}

// _calendar(calendarController: _calendarController);

_calendar(CalendarController _calendarController) {
  return TableCalendar(
      initialCalendarFormat: CalendarFormat.week,
      calendarStyle: CalendarStyle(
          weekendStyle:
              TextStyle().copyWith(color: Color.fromARGB(255, 136, 116, 184)),
          todayColor: Color.fromARGB(255, 229, 225, 237),
          todayStyle: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
          selectedColor: Color.fromARGB(255, 200, 195, 209),
          selectedStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          )),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle(
        color: Color.fromARGB(255, 136, 116, 184),
      )),
      calendarController: _calendarController);
}

_listaTarefas() {
  final TaskDao _taskDao = TaskDao();
  return Container(
    //color: Colors.red,
    child: FutureBuilder(
      initialData: List(),
      future: _taskDao.findAll(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            // TODO: Handle this case.
            break;
          case ConnectionState.waiting:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text("carregando..."),
                ],
              ),
            );
            break;
          case ConnectionState.active:
            // TODO: Handle this case.
            break;
          case ConnectionState.done:
            final List<Task> tasks = snapshot.data;
            //print(tasks.length);
            return ListView.builder(
              shrinkWrap: false,
              itemBuilder: (context, index) => Card(
                  child: ListTile(
                title: Text(tasks[index].tarefa),
                subtitle: Text("${tasks[index].start} - ${tasks[index].end}"),
              )),
              itemCount: tasks != null ? tasks.length : 0,
            );
            break;
        } 
        return Text("erro desconhecido!");
      },
    ),
  );
}
