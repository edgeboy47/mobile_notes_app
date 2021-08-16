import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_notes_app/notes/data/models/note.dart';
import 'package:mobile_notes_app/notes/data/models/task.dart';
import 'package:mobile_notes_app/notes/data/repository/repository.dart';
part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc({required this.repository}) : super(NotesLoading()) {
    add(NotesLoaded());
  }

  final Repository repository;

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

    if (event is NoteTaskAdded) {
      await repository.addTask(event.id, event.task);
      add(NotesLoaded());
    }

    if (event is NoteTaskUpdated) {
      await repository.updateTask(event.id, event.oldTask, event.newTask);
      add(NotesLoaded());
    }

    if (event is NoteTaskDeleted) {
      await repository.deleteTask(event.id, event.task);
      add(NotesLoaded());
    }
  }
}
