// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final onTodoChanged;
  final onTodoDelete;

  const TodoItem(
      {super.key,
      required this.todo,
      required this.onTodoChanged,
      required this.onTodoDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTodoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tfBlue,
        ),
        title: Text(
          todo.task.toString(),
          style: TextStyle(
              fontSize: 16,
              color: tfBlack,
              decoration: todo.isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tfRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            iconSize: 18,
            icon: const Icon(Icons.delete),
            color: Colors.white,
            onPressed: () {
              // print("Delete");
              onTodoDelete(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
