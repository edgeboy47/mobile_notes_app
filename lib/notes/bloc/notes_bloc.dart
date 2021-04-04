import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_notes_app/data/data_sources/data_source.dart';
import 'package:mobile_notes_app/data/models/note.dart';
part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc({required this.repository}) : super(NotesLoading()) {
    add(NotesLoaded());
  }

  //TODO: Switch to Repository object
  final DataSource repository;

  @override
  Stream<NotesState> mapEventToState(
    NotesEvent event,
  ) async* {
    if (event is NotesLoaded) {
      var notes = await repository.loadNotes();
      yield NotesLoadSuccess(notes);
    }
    if (event is NoteAdded) {
      await repository.addNote(event.note);
      add(NotesLoaded());
    }
    if (event is NoteUpdated) {
      await repository.updateNote(event.note, null);
      add(NotesLoaded());
    }
    if (event is NoteDeleted) {
      await repository.deleteNote(event.id);
      add(NotesLoaded());
    }
  }
}
