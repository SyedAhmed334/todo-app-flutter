// ignore_for_file: prefer_const_constructors, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:todo_app_flutter/task_controller.dart';

enum Priority { High, Normal, Low }

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          headlineSmall: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      home: ToDoApp(),
    ),
  );
}

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  TextEditingController taskNameController = TextEditingController();
  Priority _selectedPriority = Priority.Normal;
  List<TaskController> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => StatefulBuilder(
                  builder: (context, StateSetter setModalState) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: taskNameController,
                        decoration: InputDecoration(hintText: 'Add a new task'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Task Priority:',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DropdownButton<Priority>(
                            value: _selectedPriority,
                            onChanged: (value) {
                              setModalState(() {
                                if (value != null) {
                                  _selectedPriority = value;
                                }
                              });
                            },
                            items: Priority.values.map((Priority priority) {
                              return DropdownMenuItem<Priority>(
                                value: priority,
                                child:
                                    Text(priority.toString().split('.').last),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(height: 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                tasks.add(TaskController(
                                  taskName: taskNameController.text,
                                  priority: _selectedPriority
                                      .toString()
                                      .split('.')
                                      .last,
                                ));
                                Navigator.pop(context);
                              });
                            },
                            child: Text('Save'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            );
          },
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          child: Icon(Icons.add)),
      appBar: AppBar(
          title: Center(
        child: Text("My TODO"),
      )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.yellow,
              child: ListTile(
                leading: Checkbox(
                    value: tasks[index].isDone,
                    fillColor: MaterialStatePropertyAll(Colors.white),
                    checkColor: Colors.green,
                    onChanged: (value) {
                      setState(() {});
                      tasks[index].isDone = value!;
                      if (tasks[index].isDone == true) {
                        tasks.removeAt(index);
                      }
                    }),
                title: Text(
                  tasks[index].taskName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                subtitle: Text(
                  tasks[index].priority,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
