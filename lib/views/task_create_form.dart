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
  final formGlobalKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _duration = TextEditingController();
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.headline6;

    return Form(
      key: formGlobalKey,
      child: DefaultTextStyle(
        style: (textStyle != null) ? textStyle : const TextStyle(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Title"),
              const SizedBox(height: 8.0),
              _titleTextField(controller: _title),
              const SizedBox(height: 8.0),
              const Text("Description"),
              const SizedBox(height: 8.0),
              _descriptionTextField(controller: _description),
              const SizedBox(height: 8.0),
              const Text("Duration in minutes"),
              const SizedBox(height: 8.0),
              _durationTextField(controller: _duration),
              const SizedBox(height: 32.0),
              CheckboxListTile(
                value: isActive,
                onChanged: (_) => setState(() => isActive = !isActive),
                title: Text(
                  "Start timer",
                  style: Theme.of(context)
                      .textTheme
                      .headline6, // it doesn't inherit from DefaultTextStyle, idky
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              const SizedBox(height: 32.0),
              _submitButton(submitHandler: () => _submitForm(context))
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm(context) {
    final isFormValid = formGlobalKey.currentState?.validate();
    if (isFormValid != null && isFormValid) {
      final task = Task(
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
}

Widget _titleTextField({required TextEditingController controller}) {
  return TextFormField(
    controller: controller,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter a title";
      }
      return null;
    },
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
    ),
  );
}

Widget _descriptionTextField({required TextEditingController controller}) {
  return TextFormField(
    controller: controller,
    validator: (value) {
      // TODO: Move char limit to variable instead of hardcoding
      if (value != null && value.length > 100) {
        return "Exceed character limit (100)";
      }
      return null;
    },
    minLines: 3,
    maxLines: 3,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
    ),
  );
}

Widget _durationTextField({required TextEditingController controller}) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Duration is required";
      }
      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
        return "Duration must be number";
      }
      return null;
    },
    controller: controller,
    keyboardType: TextInputType.number,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
    ),
  );
}

Widget _submitButton({required void Function() submitHandler}) {
  return Align(
    alignment: Alignment.center,
    child: ElevatedButton(
      onPressed: submitHandler,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ),
      ),
      child: const Text(
        "Create",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
      ),
    ),
  );
}
