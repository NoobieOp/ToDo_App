import 'package:flutter/material.dart';
import 'package:todo_app/Widgets/todo_list.dart';
import 'package:todo_app/colors/appcolor.dart';

class TodoItem extends StatelessWidget {
  final TodoList todos;
  final onToDoChange;
  final onDeleteItem;
  const TodoItem(
      {Key? key,
      required this.todos,
      required this.onDeleteItem,
      required this.onToDoChange})
      : super(key: key);
  Widget build(context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 25),
          child: ListTile(
            onTap: () {
              onToDoChange(todos);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            tileColor: iconCOlor,
            leading: Icon(
              todos.isDone ? Icons.check_box : Icons.check_box_outline_blank,
              color: bgColor,
            ),
            title: Text(
              todos.todoText!,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  decoration: todos.isDone ? TextDecoration.lineThrough : null),
            ),
            trailing: Container(
              height: 35,
              width: 35,
              child: IconButton(
                color: delete,
                icon: Icon(Icons.delete),
                onPressed: () {
                  onDeleteItem(todos.id);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
