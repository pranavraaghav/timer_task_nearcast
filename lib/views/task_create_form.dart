import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_task_nearcast/bloc/tasks/tasks_bloc.dart';
import 'package:timer_task_nearcast/models/task.dart';

class TaskCreateForm extends StatefulWidget {
  const TaskCreateForm({Key? key}) : super(key: key);

  @override
  _TaskCreateFormState createState() => _TaskCreateFormState();
}

class _TaskCreateFormState extends State<TaskCreateForm> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _duration = TextEditingController();
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    // TODO: Add validation
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title",
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _title,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter valid name";
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              "Description",
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _description,
              minLines: 3,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              "Enter duration in minutes",
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _duration,
              keyboardType: TextInputType.number,
              // inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            CheckboxListTile(
                title: Text(
                  "Start on creation",
                  style: Theme.of(context).textTheme.headline6,
                ),
                value: isActive,
                onChanged: (value) {
                  setState(() {
                    isActive = !isActive;
                  });
                }),
            ElevatedButton(
                onPressed: () {
                  _saveForm(context);
                },
                child: const Text("Create"))
          ],
        ),
      ),
    );
  }

  void _saveForm(context) {
    Task task = Task(
      title: _title.value.text,
      description: _description.value.text,
      durationRemain: Duration(minutes: int.parse(_duration.value.text)),
      isActive: isActive,
      lastStarted: isActive ? DateTime.now() : null,
    );

    BlocProvider.of<TasksBloc>(context).add(TaskAdded(task));
    Navigator.pop(context);
  }
}
