import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For JSON encoding/decoding
import 'package:todo_app/Widgets/todo_list.dart';
import 'Widgets/widget.dart';
import 'colors/appcolor.dart';
import 'Widgets/todo.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final List<TodoList> todoList = []; // Initialize an empty list
  final todoController = TextEditingController();
  List<TodoList> _foundTodo = [];

  @override
  void initState() {
    super.initState();
    loadTodos(); // Load saved todos on app start
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: bgColor,
        appBar: topbar(),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  searchbar(runFilter),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 50, bottom: 20),
                          child: const Text(
                            "All To Do's",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: iconCOlor,
                            ),
                          ),
                        ),
                        ..._foundTodo.reversed
                            .map((todo) => TodoItem(
                                  todos: todo,
                                  onToDoChange: handle_todo_change,
                                  onDeleteItem: deleteItem,
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                          bottom: 20, right: 20, left: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: iconCOlor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: todoController,
                        decoration: InputDecoration(
                          hintText: 'Add a new note',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        addTodoItem(todoController.text);
                      },
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 40, color: iconCOlor),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widgetColor,
                        minimumSize: Size(60, 60),
                        elevation: 10,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void handle_todo_change(TodoList todo) {
    setState(() {
      todo.isDone = !todo.isDone;
      saveTodos(); // Save the list when an item is updated
    });
  }

  void deleteItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
      saveTodos(); // Save the updated list after deletion
    });
  }

  void addTodoItem(String todo) {
    setState(() {
      todoList.add(TodoList(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo));
      _foundTodo = todoList;
      saveTodos(); // Save the updated list after adding a new item
    });
    todoController.clear();
  }

  // Save the to-do list to SharedPreferences
  Future<void> saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String todoString =
        json.encode(todoList.map((todo) => todo.toJson()).toList());
    await prefs.setString('todoList', todoString);
  }

  // Load the saved to-do list from SharedPreferences
  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todoString = prefs.getString('todoList');
    if (todoString != null) {
      List todoJson = json.decode(todoString);
      setState(() {
        todoList.addAll(
            todoJson.map((jsonItem) => TodoList.fromJson(jsonItem)).toList());
        _foundTodo = todoList; // Display the loaded todos
      });
    }
  }

  void runFilter(String enteredKeyword) {
    List<TodoList> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundTodo = results;
    });
  }
}
