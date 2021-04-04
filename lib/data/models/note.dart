import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:mobile_notes_app/data/models/tag.dart';
import 'package:mobile_notes_app/data/models/task.dart';
part 'note.g.dart';

// TODO: Implement HiveList for other fields and regenerate build_runner file
// TODO: generate note uuid on instantiation

@HiveType(typeId: 0)
class Note extends Equatable {
  const Note({
    required this.body,
    required this.title,
    required this.dateTime,
    required this.id,
    this.tags,
    this.tasks,
  });

  @HiveField(0)
  final String title;

  @HiveField(1)
  final String body;

  @HiveField(2)
  final DateTime dateTime;

  @HiveField(3)
  final String id;

  @HiveField(4)
  final List<Tag>? tags;

  @HiveField(5)
  final List<Task>? tasks;

  @override
  List<Object?> get props => [
        body,
        title,
        dateTime,
        id,
        tags,
        tasks,
      ];

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
