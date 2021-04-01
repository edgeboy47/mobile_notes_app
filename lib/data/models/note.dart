import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
// import 'package:mobile_notes_app/data/models/tag.dart';
// import 'package:mobile_notes_app/data/models/task.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends Equatable {
  const Note({
    required this.body,
    required this.title,
    required this.dateTime,
    required this.id,
    // this.tags,
    // this.tasks,
  });

  @HiveField(0)  
  final String title;

  @HiveField(1)
  final String body;

  @HiveField(2)
  final DateTime dateTime;

  // final List<Tag>? tags;
  // final List<Task>? tasks;
  @HiveField(3)
  final String id;

  @override
  List<Object?> get props => [
        body,
        title,
        dateTime,
        id,
        // tags,
        // tasks,
      ];
}
