import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timer_task_nearcast/bloc/tasks/tasks_bloc.dart';
import 'package:timer_task_nearcast/models/task.dart';
import 'package:timer_task_nearcast/views/task_edit_page.dart';

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
      child: Slidable(
        key: const ValueKey(0),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 35, 0),
                        child: Text(
                          widget.task.description,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  _getRemainingTimeText(),
                  // TODO: Rewrite this is a better (using Theme preferably)
                  style: widget.task.isActive
                      ? const TextStyle(color: Colors.green, fontSize: 20)
                      : const TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ],
            ),
          ),
          onTap: () {
            _isActiveToggle(context);
          },
        ),
        endActionPane: ActionPane(
          extentRatio: 0.4,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                context.read<TasksBloc>().add(TaskRemoved(widget.task));
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        startActionPane: ActionPane(
          extentRatio: 0.4,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TaskEditPage(task: widget.task)),
                );
              },
              backgroundColor: Colors.blue.shade400,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
      ),
      clipBehavior: Clip.hardEdge,
    );
  }

  String _getRemainingTimeText() {
    Duration durationRemain = widget.task.durationRemain;
    if (widget.task.isActive) {
      durationRemain = _calculateDurationRemain();
    }
    return durationRemain.toString().substring(0, 7);
  }

  Duration _calculateDurationRemain() {
    final timeElapsedSinceStarting =
        DateTime.now().difference(widget.task.lastStarted);
    Duration durationRemain =
        widget.task.durationRemain - timeElapsedSinceStarting;
    return durationRemain.isNegative
        ? const Duration(seconds: 0)
        : durationRemain;
  }

  _isActiveToggle(BuildContext context) {
    Task newTask;
    if (widget.task.isActive) {
      newTask = widget.task.copyWith(
        isActive: !widget.task.isActive,
        durationRemain: _calculateDurationRemain(),
      );
    } else {
      newTask = widget.task.copyWith(
        isActive: !widget.task.isActive,
        lastStarted: DateTime.now(),
      );
    }
    BlocProvider.of<TasksBloc>(context).add(TaskUpdated(newTask));
  }
}
