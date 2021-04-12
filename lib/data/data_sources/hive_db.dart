import 'package:hive/hive.dart';
import 'package:mobile_notes_app/data/data_sources/data_source.dart';
import 'package:mobile_notes_app/data/models/note.dart';

class HiveDatabase implements DataSource {
  HiveDatabase({required this.notesBox});

  // TODO: Add tasks and tags boxes, and crud functions for each
  // TODO: Link tasks to their respective note, Box<List<Task>> where note id is the key
  Box<Note> notesBox;

  Future<void> _init() async {
    if (notesBox.isOpen) return;

    await Hive.openBox('notesBox');
    notesBox = Hive.box('notesBox');
  }

  @override
  Future<void> addNote(Note note) async {
    if (notesBox.isOpen)
      await notesBox.put(note.id, note);
    else {
      await _init();
      await notesBox.put(note.id, note);
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    if (notesBox.isOpen)
      await notesBox.delete(id);
    else {
      await _init();
      await notesBox.delete(id);
    }
  }

  @override
  Future<List<Note>> loadNotes() async {
    if (notesBox.isOpen)
      return notesBox.values.toList();
    else {
      await _init();
      return notesBox.values.toList();
    }
  }

  @override
  Future<void> updateNote(Note note, String? id) async {
    await addNote(note);
  }
}
