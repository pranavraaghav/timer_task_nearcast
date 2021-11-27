import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timer_task_nearcast/views/task_create_form.dart';

class TaskCreatePage extends StatelessWidget {
  const TaskCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create a task"),
        ),
        body: const SingleChildScrollView(
          child: TaskCreateForm(),
        ),
      ),
    );
  }
}
