import 'package:hive/hive.dart';
import 'package:mobile_notes_app/data/data_sources/data_source.dart';
import 'package:mobile_notes_app/data/models/note.dart';
import 'package:mobile_notes_app/data/models/tag.dart';
import 'package:mobile_notes_app/data/models/task.dart';

class HiveDatabase implements DataSource {
  HiveDatabase({
    required this.notesBox,
    required this.tagsBox,
  });

  // TODO: Add tasks and tags boxes, and crud functions for each
  // TODO: Link tasks to their respective note, Box<List<Task>> where note id is the key
  Box<Note> notesBox;

  Box<Tag> tagsBox;

  Future<void> _init() async {
    if (notesBox.isOpen && tagsBox.isOpen) return;

    await Hive.openBox('notesBox');
    notesBox = Hive.box('notesBox');

    await Hive.openBox('tagsBox');
    tagsBox = Hive.box('tagsBox');
  }

  // Note Functions
  @override
  Future<void> addNote(Note note) async {
    if (notesBox.isOpen == false) await _init();
    await notesBox.put(note.id, note);
  }

  @override
  Future<void> deleteNote(String id) async {
    if (notesBox.isOpen == false) await _init();
    await notesBox.delete(id);
  }

  @override
  Future<List<Note>> loadNotes() async {
    if (notesBox.isOpen == false) await _init();
    return notesBox.values.toList();
  }

  @override
  Future<void> updateNote(Note note, String? id) async {
    await addNote(note);
  }

  // Tag Functions
  @override
  Future<void> addTag(Tag tag) async {
    if (tagsBox.isOpen == false) await _init();
    await tagsBox.put(tag.title, tag);
  }

  @override
  Future<void> deleteTag(String title) async {
    if (tagsBox.isOpen == false) await _init();
    await tagsBox.delete(title);
  }

  @override
  Future<List<Tag>> loadTags() async {
    if (tagsBox.isOpen == false) await _init();
    return tagsBox.values.toList();
  }

  @override
  Future<void> updateTag(Tag tag, String title) async {
    await addTag(tag);
    await deleteTag(title);
  }

  // Task Functions
  @override
  Future<void> addTask(String noteId, Task task) async {
    if (notesBox.isOpen == false) await _init();

    final note = notesBox.get(noteId);
    final tasks = note?.tasks;

    await updateNote(
      note!.copyWith(
        tasks: tasks == null ? [task] : [...tasks, task],
        dateTime: DateTime.now(),
      ),
      noteId,
    );
  }

  Future<void> addTasks(String noteId, List<Task> tasks) async {
    for (final task in tasks) await addTask(noteId, task);
  }

  @override
  Future<void> deleteTask(String noteId, Task task) async {
    if (notesBox.isOpen == false) await _init();

    final note = notesBox.get(noteId);
    final tasks = note?.tasks;

    if (tasks == null) return;

    tasks.remove(task);

    await updateNote(
      note!.copyWith(
        tasks: tasks,
        dateTime: DateTime.now(),
      ),
      noteId,
    );
  }

  //TODO: Implement update task
  @override
  Future<void> updateTask(String noteId, Task task) async {
    if (notesBox.isOpen == false) await _init();

    final note = notesBox.get(noteId);
    final tasks = note?.tasks;

    if (tasks == null) return;
  }
}
