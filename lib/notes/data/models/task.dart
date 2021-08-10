import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 2)
class Task extends Equatable {
  const Task({required this.body, required this.isCompleted});

  @HiveField(0)
  final String body;

  @HiveField(1)
  final bool isCompleted;

  @override
  List<Object?> get props => [body, isCompleted];

  Task copyWith({String? body, bool? isCompleted}) {
    return Task(
      body: body ?? this.body,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
