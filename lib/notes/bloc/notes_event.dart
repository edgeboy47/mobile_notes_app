part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class NoteAdded extends NotesEvent {
  NoteAdded(this.note);

  final Note note;
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
