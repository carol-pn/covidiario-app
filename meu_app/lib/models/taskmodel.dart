class Task{
  int id;
  String tarefa;
  int dia;
  int start;
  int end;

  Task(this.tarefa, this.start, this.end, {this.id = 0});

  @override
  String toString() {
    // TODO: implement toString
    return 'Task{id: $id, tarefa: $tarefa, start: $start, end: $end}';
  }

}
  
