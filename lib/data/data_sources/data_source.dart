import 'package:mobile_notes_app/data/models/note.dart';

abstract class DataSource {
  Future<void> addNote(Note note);

  Future<List<Note>> loadNotes();

  Future<void> deleteNote(String id);

  Future<void> updateNote();
}
