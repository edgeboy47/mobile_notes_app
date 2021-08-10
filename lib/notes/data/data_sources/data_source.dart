import 'package:mobile_notes_app/notes/data/models/note.dart';
import 'package:mobile_notes_app/notes/data/models/tag.dart';
import 'package:mobile_notes_app/notes/data/models/task.dart';

abstract class DataSource {
  // Note Functions
  Future<void> addNote(Note note);

  Future<List<Note>> loadNotes();

  Future<void> deleteNote(String id);

  Future<void> updateNote(Note note, String? id);
  
  // Tag Functions
  Future<void> addTag(Tag tag);

  Future<List<Tag>> loadTags();

  Future<void> deleteTag(String title);

  Future<void> updateTag(Tag tag, String title);

  // Task Functions
  Future<void> addTask(String noteId, Task task);

  Future<void> deleteTask(String noteId, Task task);

  Future<void> updateTask(String noteId, Task oldTask, Task newTask);
}
