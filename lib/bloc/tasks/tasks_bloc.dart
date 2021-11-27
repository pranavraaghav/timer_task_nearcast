import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timer_task_nearcast/models/task.dart';
import 'package:timer_task_nearcast/tasks_repository.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc({required this.tasksRepository}) : super(TasksLoading()) {
    on<TasksStarted>(_onStarted);
    on<TaskAdded>(_onAdded);
    on<TaskUpdated>(_onUpdated);
    on<TaskRemoved>(_onRemoved);
  }

  final TasksRepository tasksRepository;

  void _onStarted(TasksStarted event, Emitter<TasksState> emit) async {
    emit(TasksLoading());
    try {
      final tasks = await tasksRepository.loadTasks();
      emit(TasksLoaded(tasks: [...tasks]));
    } catch (e) {
      emit(TasksError());
    }
  }

  void _onAdded(TaskAdded event, Emitter<TasksState> emit) {
    final state = this.state;

    if (state is TasksLoaded) {
      try {
        tasksRepository.addTask(event.task);
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
        tasksRepository.removeTask(event.task);
        final updated = state.tasks.where((task) => task.id != event.task.id);
        emit(TasksLoaded(tasks: [...updated]));
      } catch (_) {
        emit(TasksError());
      }
    }
  }
}
