import 'package:mobile_notes_app/notes/data/data_sources/data_source.dart';
import 'package:mobile_notes_app/notes/data/models/note.dart';

abstract class Repository {
  const Repository({required this.dataSource});

  final DataSource dataSource;

  Future<void> addNote(Note note);

  Future<List<Note>> loadNotes();

  Future<void> deleteNote(String id);

  Future<void> updateNote();
}
