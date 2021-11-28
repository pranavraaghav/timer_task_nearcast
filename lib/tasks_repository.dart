import 'package:timer_task_nearcast/models/task.dart';

const _delay = Duration(
  milliseconds: 200,
); // Artificial Delay to support server side fetching later on

class TasksRepository {
  final _tasks = <Task>[];

  Future<List<Task>> loadTasks() => Future.delayed(_delay, () => _tasks);

  void addTask(Task task) => _tasks.add(task);

  void removeTask(Task task) => _tasks.remove(task);
}
