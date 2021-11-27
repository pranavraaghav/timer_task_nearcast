import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_task_nearcast/bloc/tasks/tasks_bloc.dart';
import 'package:timer_task_nearcast/models/task.dart';

class TasksListItem extends StatelessWidget {
  const TasksListItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.grey.shade50,
      elevation: 2,
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    task.description,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Text(
                _calculateRemainingTime(),
                // TODO: Rewrite this is a better (using Theme preferably)
                style: task.isActive
                    ? const TextStyle(color: Colors.red, fontSize: 20)
                    : const TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ],
          ),
        ),
        // TODO: Handle deletion like a sane person
        onLongPress: () {
          context.read<TasksBloc>().add(TaskRemoved(task));
        },
      ),
      clipBehavior: Clip.hardEdge,
    );
  }

  String _calculateRemainingTime() {
    int secsRemain = task.durationRemain;
    if (task.isActive) {
      final timeDiffSecs =
          DateTime.now().difference(task.lastStarted).inSeconds;
      secsRemain = secsRemain - timeDiffSecs;
      if (secsRemain < 0) secsRemain = 0;
    }
    return Duration(seconds: secsRemain).toString().substring(0, 7);
  }
}
