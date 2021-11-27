part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState();
}

class TasksLoading extends TasksState {
  @override
  List<Object?> get props => [];
}

class TasksLoaded extends TasksState {
  const TasksLoaded({required this.tasks});

  final List<Task> tasks;

  @override
  List<Object> get props => [tasks];

  @override
  String toString() => 'TasksReady: { tasks: $tasks}';
}

class TasksError extends TasksState {
  @override
  List<Object?> get props => [];
}
