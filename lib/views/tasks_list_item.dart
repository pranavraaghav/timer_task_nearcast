import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_task_nearcast/bloc/tasks/tasks_bloc.dart';
import 'package:timer_task_nearcast/models/task.dart';

class TasksListItem extends StatefulWidget {
  const TasksListItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  State<TasksListItem> createState() => _TasksListItemState();
}

class _TasksListItemState extends State<TasksListItem> {
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
                    widget.task.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    widget.task.description,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Text(
                _calculateRemainingTime(),
                // TODO: Rewrite this is a better (using Theme preferably)
                style: widget.task.isActive
                    ? const TextStyle(color: Colors.green, fontSize: 20)
                    : const TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ],
          ),
        ),
        // TODO: Handle deletion like a sane person
        onLongPress: () {
          context.read<TasksBloc>().add(TaskRemoved(widget.task));
        },
      ),
      clipBehavior: Clip.hardEdge,
    );
  }

  String _calculateRemainingTime() {
    Duration secsRemain = widget.task.durationRemain;
    if (widget.task.isActive) {
      final timeDiffSecs = DateTime.now().difference(widget.task.lastStarted);
      secsRemain = secsRemain - timeDiffSecs;
      if (secsRemain.isNegative) secsRemain = const Duration(seconds: 0);
    }
    return secsRemain.toString().substring(0, 7);
  }
}
