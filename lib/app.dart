import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_task_nearcast/bloc/tasks/tasks_bloc.dart';
import 'package:timer_task_nearcast/views/tasks_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TasksBloc()..add(TasksStarted()),
      child: MaterialApp(
        title: 'Flutter Bloc Timer App',
        theme: ThemeData(primarySwatch: Colors.green),
        home: const TasksPage(),
      ),
    );
  }
}
