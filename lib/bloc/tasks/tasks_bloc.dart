import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timer_task_nearcast/models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksLoading()) {
    on<TasksStarted>(_onStarted);
    on<TaskAdded>(_onAdded);
    on<TaskUpdated>(_onUpdated);
    on<TaskRemoved>(_onRemoved);
  }

  void _onStarted(TasksStarted event, Emitter<TasksState> emit) async {
    emit(TasksLoading());
    try {
      emit(const TasksLoaded(tasks: <Task>[]));
    } catch (e) {
      emit(TasksError());
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
