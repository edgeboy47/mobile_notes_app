import 'package:equatable/equatable.dart';

class Task extends Equatable {
  const Task({required this.body, required this.isCompleted});

  final String body;
  final bool isCompleted;

  @override
  List<Object?> get props => [body, isCompleted];
}
