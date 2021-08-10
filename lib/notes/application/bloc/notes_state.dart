part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class NotesLoading extends NotesState {}

class NotesLoadSuccess extends NotesState {
  const NotesLoadSuccess(this.notes);

  final List<Note> notes;

  @override
  List<Object> get props => [notes];
}

class NotesLoadFailed extends NotesState {}
