part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class NoteAdded extends NotesEvent {
  NoteAdded(this.note);

  final Note note;

  @override
  List<Object> get props => [note];
}

class NotesLoaded extends NotesEvent {}

class NoteUpdated extends NotesEvent {
  NoteUpdated(this.note);

  final Note note;

  @override
  List<Object> get props => [note];
}

class NoteDeleted extends NotesEvent {
  NoteDeleted(this.id);

  final String id;
}

class NoteTaskAdded extends NotesEvent {
  NoteTaskAdded(this.id, this.task);

  final Task task;
  final String id;

  @override
  List<Object> get props => [id, task];
}

class NoteTaskDeleted extends NotesEvent {
  NoteTaskDeleted(this.id, this.task);

  final Task task;
  final String id;

  @override
  List<Object> get props => [id, task];
}

class NoteTaskUpdated extends NotesEvent {
  NoteTaskUpdated({
    required this.id,
    required this.oldTask,
    required this.newTask,
  });

  final Task oldTask;
  final Task newTask;
  final String id;

  @override
  List<Object> get props => [id, oldTask, newTask];
}

class NotesCleared extends NotesEvent {}
