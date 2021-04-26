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
  NoteTaskAdded(this.noteId, this.task);

  final Task task;
  final String noteId;

  @override
  List<Object> get props => [task];
}

class NoteTaskDeleted extends NotesEvent {
  NoteTaskDeleted(this.noteId, this.task);

  final Task task;
  final String noteId;

  @override
  List<Object> get props => [task];
}

class NoteTaskUpdated extends NotesEvent {
  NoteTaskUpdated(this.noteId, this.task);

  final Task task;
  final String noteId;

  @override
  List<Object> get props => [task];
}
