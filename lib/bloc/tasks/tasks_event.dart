part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class TasksStarted extends TasksEvent {
  @override
  List<Object> get props => [];
}

class TaskAdded extends TasksEvent {
  const TaskAdded(this.task);

  final Task task;

  @override
  List<Object> get props => [task];
}

class TaskUpdated extends TasksEvent {
  const TaskUpdated(this.task);

  final Task task;

  @override
  List<Object> get props => [task];
}

class TaskRemoved extends TasksEvent {
  const TaskRemoved(this.task);

  final Task task;

  @override
  List<Object> get props => [task];
}
