import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timer_task_nearcast/models/task.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksLoading()) {
    on<TaskAdded>(_onAdded);
    on<TaskUpdated>(_onUpdated);
    on<TaskRemoved>(_onRemoved);
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    List<dynamic> tasksJson = [];
    try {
      tasksJson = jsonDecode(json["value"]);
      List<Task> tasks = tasksJson.map((task) => Task.fromJson(task)).toList();
      return TasksLoaded(tasks: tasks);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    if (state is TasksLoaded) {
      String value = jsonEncode(state.tasks);
      return <String, dynamic>{"value": value};
    } else {
      return null;
    }
  }

  void _onAdded(TaskAdded event, Emitter<TasksState> emit) {
    final state = this.state;

    if (state is TasksLoaded) {
      try {
        emit(TasksLoaded(tasks: [...state.tasks, event.task]));
      } catch (_) {
        emit(TasksError());
      }
    }
  }

  void _onUpdated(TaskUpdated event, Emitter<TasksState> emit) {
    final state = this.state;

    if (state is TasksLoaded) {
      final updated = state.tasks.map((task) {
        if (task.id == event.task.id) {
          return event.task;
        } else {
          return task;
        }
      });
      emit(TasksLoaded(tasks: [...updated]));
    }
  }

  void _onRemoved(TaskRemoved event, Emitter<TasksState> emit) {
    final state = this.state;

    if (state is TasksLoaded) {
      try {
        final updated = state.tasks.where((task) => task.id != event.task.id);
        emit(TasksLoaded(tasks: [...updated]));
      } catch (_) {
        emit(TasksError());
      }
    }
  }
}
