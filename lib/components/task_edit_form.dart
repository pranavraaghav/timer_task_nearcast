import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_task_nearcast/bloc/tasks/tasks_bloc.dart';
import 'package:timer_task_nearcast/models/task.dart';

class TaskEditForm extends StatefulWidget {
  const TaskEditForm({
    Key? key,
    required this.task,
  }) : super(key: key);
  final Task task;

  @override
  _TaskEditFormState createState() => _TaskEditFormState();
}

class _TaskEditFormState extends State<TaskEditForm> {
  final formGlobalKey = GlobalKey<FormState>();
  late TextEditingController _title;
  late TextEditingController _description;

  @override
  void initState() {
    _title = TextEditingController(text: widget.task.title);
    _description = TextEditingController(text: widget.task.description);
    super.initState();
  }

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
              const SizedBox(height: 64.0),
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
      final updatedTask = widget.task.copyWith(
        title: _title.value.text,
        description: _description.value.text,
      );

      BlocProvider.of<TasksBloc>(context).add(TaskUpdated(updatedTask));
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
        "Update",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
      ),
    ),
  );
}
