import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_task_nearcast/bloc/tasks/tasks_bloc.dart';
import 'package:timer_task_nearcast/components/tasks_list_item.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  void initState() {
    super.initState();
    /**
     * TaskListItem shows remaining time according to 
     * time it was last rendered.
     * We force re-render the page every second to 
     * render all TaskListItems with latest timer details. 
     */
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is TasksLoading) {
          return const CircularProgressIndicator();
        }
        if (state is TasksLoaded) {
          return ListView.separated(
            itemCount: state.tasks.length,
            separatorBuilder: (_, __) => const SizedBox(height: 4),
            itemBuilder: (context, index) {
              final item = state.tasks[index];
              return TasksListItem(task: item);
            },
          );
        }
        return const Text("Oh no, something went wrong");
      },
    );
  }
}
