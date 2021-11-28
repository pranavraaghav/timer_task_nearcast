import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final Duration durationRemain;
  final DateTime lastStarted;
  final bool isActive;

  Task({
    String? id,
    DateTime? lastStarted,
    bool? isActive,
    required this.title,
    required this.description,
    required this.durationRemain,
  })  : id = id ?? const Uuid().v4(),
        isActive = isActive ?? false,
        lastStarted = lastStarted ?? DateTime.now();

  Task copyWith({
    String? id,
    String? title,
    String? description,
    Duration? durationRemain,
    DateTime? lastStarted,
    bool? isActive,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      durationRemain: durationRemain ?? this.durationRemain,
      lastStarted: lastStarted ?? this.lastStarted,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      durationRemain,
      lastStarted,
      isActive,
    ];
  }

  @override
  String toString() {
    return 'Task { id: $id, title: $title, description: $description, durationRemain: $durationRemain, lastStarted: $lastStarted, isActive: $isActive}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'durationRemain': durationRemain.inSeconds,
      'lastStarted': lastStarted.millisecondsSinceEpoch,
      'isActive': isActive,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      durationRemain: Duration(seconds: map['durationRemain']),
      lastStarted: DateTime.fromMillisecondsSinceEpoch(map['lastStarted']),
      isActive: map['isActive'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
