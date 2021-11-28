part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState();
}

class TasksLoading extends TasksState {
  @override
  List<Object?> get props => [];
}

class TasksError extends TasksState {
  @override
  List<Object?> get props => [];
}

class TasksLoaded extends TasksState {
  const TasksLoaded({
    required this.tasks,
  });

  final List<Task> tasks;

  @override
  List<Object> get props => [tasks];

  @override
  String toString() => 'TasksLoaded(tasks: $tasks)';

  TasksLoaded copyWith({
    List<Task>? tasks,
  }) {
    return TasksLoaded(
      tasks: tasks ?? this.tasks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tasks': tasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TasksLoaded.fromMap(Map<String, dynamic> map) {
    return TasksLoaded(
      tasks: List<Task>.from(map['tasks']?.map((x) => Task.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TasksLoaded.fromJson(String source) =>
      TasksLoaded.fromMap(json.decode(source));
}
