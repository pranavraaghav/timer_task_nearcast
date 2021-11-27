import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_task_nearcast/bloc/tasks/tasks_bloc.dart';
import 'package:timer_task_nearcast/tasks_repository.dart';
import 'package:timer_task_nearcast/views/tasks_page.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.tasksRepository}) : super(key: key);

  final TasksRepository tasksRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TasksBloc(
            tasksRepository: tasksRepository,
          )..add(TasksStarted()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Bloc Timer App',
        theme: ThemeData(primarySwatch: Colors.green),
        home: const TasksPage(),
      ),
    );
  }
}
