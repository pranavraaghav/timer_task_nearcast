import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timer_task_nearcast/app.dart';
import 'package:timer_task_nearcast/tasks_repository.dart';

void main() {
  runApp(App(tasksRepository: TasksRepository()));
}
