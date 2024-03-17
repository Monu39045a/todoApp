import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/widgets/todo_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todoList = Todo.listItems();
  List<Todo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _foundToDo = todoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tfBg,
      appBar: _appbar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                searchBar(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text(
                          "All ToDos",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (Todo todo in _foundToDo.reversed)
                        TodoItem(
                          todo: todo,
                          onTodoChanged: _handleToDoChange,
                          onTodoDelete: _handleToDoDelete,
                        ),
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
                    margin:
                        const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                        hintText: "Add a new Task",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _addToDoTask(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tfBlue,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text(
                      "+",
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      backgroundColor: tfBg,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tfBlack,
            size: 30,
          ),
          SizedBox(
            height: 50,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('images/avatar.png'),
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleToDoDelete(String id) {
    setState(() {
      todoList.removeWhere((element) => element.id == id);
    });
  }

  void _addToDoTask(String todo) {
    setState(() {
      if (_todoController.text.isNotEmpty) {
        todoList.add(
          Todo(
              id: DateTime.now().millisecondsSinceEpoch.toString(), task: todo),
        );
      }
    });
    _todoController.clear();
  }

  void _runFilter(String keywords) {
    List<Todo> results = [];
    if (keywords.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((element) =>
              element.task!.toLowerCase().contains(keywords.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          fillColor: tfBg,
          contentPadding: EdgeInsets.all(0),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search_sharp,
            color: tfBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 25,
            minWidth: 30,
          ),
          hintText: "Search",
          hintStyle: TextStyle(color: tfGrey),
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
