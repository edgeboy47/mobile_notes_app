import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_notes_app/notes/data/data_sources/data_source.dart';
import 'package:mobile_notes_app/notes/data/models/task.dart';
import 'package:mobile_notes_app/notes/data/models/tag.dart';
import 'package:mobile_notes_app/notes/data/models/note.dart';

class FirestoreDataSource implements DataSource {
  final notesCollection = FirebaseFirestore.instance
      .collection('notes')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('user_notes');

  // Note Functions
  @override
  Future<void> addNote(Note note) async {
    await notesCollection.doc(note.id).set(note.toJson());
  }

  @override
  Future<void> deleteNote(String id) async {
    await notesCollection.doc(id).delete();
  }

  @override
  Future<List<Note>> loadNotes() async {
    return (await notesCollection.get()).docs.map((snapshot) {
      final data = snapshot.data();
      print(data);
      return Note.fromJson(data);
    }).toList();
  }

  @override
  Future<void> updateNote(Note note, String? id) async {
    await addNote(note);
  }

  //----------------------------------------------------------------------------
  // Task Functions
  @override
  Future<void> addTask(String id, Task task) async {
    final noteDocument = await (notesCollection.doc(id).get());

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
    final noteDocument = await (notesCollection.doc(id).get());

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
    final noteDocument = await (notesCollection.doc(id).get());

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
