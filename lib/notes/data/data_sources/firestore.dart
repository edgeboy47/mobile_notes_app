import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_notes_app/notes/data/data_sources/data_source.dart';
import 'package:mobile_notes_app/notes/data/models/task.dart';
import 'package:mobile_notes_app/notes/data/models/tag.dart';
import 'package:mobile_notes_app/notes/data/models/note.dart';

class FirestoreDataSource implements DataSource {
  final notesCollection = FirebaseFirestore.instance.collection('notes');

  // Note Functions
  @override
  Future<void> addNote(Note note) async {
    await notesCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('user_notes')
        .doc(note.id)
        .set(note.toJson());
  }

  @override
  Future<void> deleteNote(String id) async {
    await notesCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('user_notes')
        .doc(id)
        .delete();
  }

  @override
  Future<List<Note>> loadNotes() async {
    return (await notesCollection
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('user_notes')
            .get())
        .docs
        .map((snapshot) => Note.fromJson(snapshot.data()))
        .toList();
  }

  @override
  Future<void> updateNote(Note note, String? id) async {
    await addNote(note);
  }

  @override
  Future<List<Note>> loadNotesWithCompletedTasks() async {
    final notes = await loadNotes();

    final filteredNotes = notes
        .where((note) =>
            note.tasks != null && note.tasks!.any((task) => task.isCompleted))
        .map((note) {
      final tasks = note.tasks;
      return note.copyWith(
          tasks: tasks!.where((task) => task.isCompleted).toList());
    });

    return filteredNotes.toList();
  }

  //----------------------------------------------------------------------------
  // Task Functions
  @override
  Future<void> addTask(String id, Task task) async {
    final noteDocument = await (notesCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('user_notes')
        .doc(id)
        .get());

    if (noteDocument.exists) {
      final note = Note.fromJson(noteDocument.data()!);
      final tasks = note.tasks;

      await updateNote(
        note.copyWith(
          tasks: tasks == null ? [task] : [...tasks, task],
          dateTime: DateTime.now(),
        ),
        id,
      );
    }
  }

  @override
  Future<void> deleteTask(String id, Task task) async {
    final noteDocument = await (notesCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('user_notes')
        .doc(id)
        .get());

    if (noteDocument.exists) {
      final note = Note.fromJson(noteDocument.data()!);
      final tasks = note.tasks;

      if (tasks == null) return;

      if (tasks.contains(task))
        tasks.remove(task);
      else
        tasks.remove(const Task(body: '', isCompleted: false));

      await updateNote(
        note.copyWith(tasks: tasks, dateTime: DateTime.now()),
        id,
      );
    }
  }

  @override
  Future<void> updateTask(String id, Task oldTask, Task newTask) async {
    final noteDocument = await (notesCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('user_notes')
        .doc(id)
        .get());

    if (noteDocument.exists) {
      final note = Note.fromJson(noteDocument.data()!);
      final tasks = note.tasks;
      if (tasks == null) return;

      final index = tasks.indexOf(oldTask);

      tasks.replaceRange(index, index + 1, [newTask]);

      await updateNote(
        note.copyWith(tasks: tasks, dateTime: DateTime.now()),
        id,
      );
    }
  }

  //----------------------------------------------------------------------------
  // Tag Functions
  @override
  Future<void> addTag(Tag tag) {
    // TODO: implement addTag
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTag(String title) {
    // TODO: implement deleteTag
    throw UnimplementedError();
  }

  @override
  Future<List<Tag>> loadTags() {
    // TODO: implement loadTags
    throw UnimplementedError();
  }

  @override
  Future<void> updateTag(Tag tag, String title) {
    // TODO: implement updateTag
    throw UnimplementedError();
  }
}
