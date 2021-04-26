import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:mobile_notes_app/data/models/tag.dart';
import 'package:mobile_notes_app/data/models/task.dart';
import 'package:uuid/uuid.dart';
part 'note.g.dart';

// TODO: Implement HiveList for other fields and regenerate build_runner file

@HiveType(typeId: 0)
class Note extends Equatable {
  Note({
    required this.body,
    required this.title,
    required this.dateTime,
    String? id,
    this.tags,
    this.tasks,
  }) : id = id ?? const Uuid().v1();

  @HiveField(0)
  final String title;

  @HiveField(1)
  final String body;

  @HiveField(2)
  final DateTime dateTime;

  @HiveField(3)
  final String? id;

  @HiveField(4)
  final List<Tag>? tags;

  @HiveField(5)
  final List<Task>? tasks;

  @override
  List<Object?> get props => [
        body,
        title,
        id,
        tags,
        tasks,
      ];

  void addTask(Task task) {
    tasks?.add(task);
  }

  void updateTask(Task task, Task newTask) {
    if (tasks != null) {
      final index = tasks!.indexOf(task);

      tasks!.replaceRange(index, index + 1, [newTask]);
    }
  }

  void deleteTask(Task task) {
    tasks?.removeWhere((element) => element == task);
  }

  Note copyWith({
    String? body,
    String? title,
    DateTime? dateTime,
    String? id,
    List<Tag>? tags,
    List<Task>? tasks,
  }) {
    return Note(
      body: body ?? this.body,
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      id: id ?? this.id,
      tags: tags ?? this.tags,
      tasks: tasks ?? this.tasks,
    );
  }
}
