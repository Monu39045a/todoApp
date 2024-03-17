import 'dart:core';

class Todo {
  String? id;
  String? task;
  bool isDone;

  Todo({required this.id, required this.task, this.isDone = false});

  static List<Todo> listItems() {
    return [
      Todo(id: '01', task: 'Morning Exercise', isDone: true),
      Todo(id: '02', task: 'Do BreakFast', isDone: true),
      Todo(id: '03', task: 'Study Machine Leaning'),
      Todo(id: '04', task: 'Study Flutter'),
      Todo(id: '05', task: 'Do DSA'),
    ];
  }
}
