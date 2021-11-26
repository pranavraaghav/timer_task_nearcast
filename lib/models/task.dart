import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final int durationRemain;
  final DateTime lastStarted;
  final bool isActive;

  Task({
    String? id,
    required this.title,
    required this.description,
    required this.durationRemain,
    DateTime? lastStarted,
    bool? isActive,
  })  : id = id ?? const Uuid().v4(),
        isActive = isActive ?? false,
        lastStarted = lastStarted ?? DateTime.now();

  Task copyWith({
    String? id,
    String? title,
    String? description,
    int? durationRemain,
    DateTime? lastStarted,
    bool? isActive,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.title,
      durationRemain: durationRemain ?? this.durationRemain,
      lastStarted: lastStarted ?? this.lastStarted,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, description, durationRemain, lastStarted, isActive];

  @override
  String toString() {
    return 'Task { id: $id, title: $title, description: $description, durationRemain: $durationRemain, lastStarted: $lastStarted, isActive: $isActive}';
  }
}
