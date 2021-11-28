import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timer_task_nearcast/components/task_edit_form.dart';
import 'package:timer_task_nearcast/models/task.dart';

class TaskEditPage extends StatelessWidget {
  const TaskEditPage({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit a task"),
        ),
        body: SingleChildScrollView(
          child: TaskEditForm(task: task),
        ),
      ),
    );
  }
}
