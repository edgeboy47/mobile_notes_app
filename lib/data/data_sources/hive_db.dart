import 'package:hive/hive.dart';
import 'package:mobile_notes_app/data/data_sources/data_source.dart';
import 'package:mobile_notes_app/data/models/note.dart';

class HiveDatabase implements DataSource {
  HiveDatabase() : _notesBox = Hive.box('notesBox');

  // TODO: Add tasks and tags boxes, and crud functions for each
  // TODO: Link tasks to their respective note, Box<List<Task>> where note id is the key
  Box<Note> _notesBox;

  Future<void> _init() async {
    if (_notesBox.isOpen) return;

    await Hive.openBox('notesBox');
    _notesBox = Hive.box('notesBox');
  }

  @override
  Future<void> addNote(Note note) async {
    if (_notesBox.isOpen)
      await _notesBox.put(note.id, note);
    else {
      await _init();
      await _notesBox.put(note.id, note);
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    if (_notesBox.isOpen)
      await _notesBox.delete(id);
    else {
      await _init();
      await _notesBox.delete(id);
    }
  }

  @override
  Future<List<Note>> loadNotes() async {
    if (_notesBox.isOpen)
      return _notesBox.values.toList();
    else {
      await _init();
      return _notesBox.values.toList();
    }
  }

  @override
  Future<void> updateNote(Note note, String? id) async {
    await addNote(note);
  }
}
