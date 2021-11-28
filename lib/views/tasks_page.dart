import 'package:flutter/material.dart';
import 'package:timer_task_nearcast/views/task_create_page.dart';
import 'package:timer_task_nearcast/components/tasks_list.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tasks")),
      body: ColoredBox(
        color: Colors.grey.shade200,
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: TasksList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TaskCreatePage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
