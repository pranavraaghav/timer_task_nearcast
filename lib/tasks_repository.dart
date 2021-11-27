import 'package:timer_task_nearcast/models/task.dart';

const _delay = Duration(
  milliseconds: 500,
); // Artificial Delay to support server side fetching later on

class TasksRepository {
  final _tasks = <Task>[
    Task(
      title: "Task 1",
      description: "Description 1",
      durationRemain: 10,
    ),
    Task(
      title: "Task 2",
      description: "Description 2",
      durationRemain: 20,
    ),
  ];

  Future<List<Task>> loadTasks() => Future.delayed(_delay, () => _tasks);

  void addTask(Task task) => _tasks.add(task);

  void removeTask(Task task) => _tasks.remove(task);
}
