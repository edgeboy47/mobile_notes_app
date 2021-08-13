import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_notes_app/notes/data/data_sources/data_source.dart';
import 'package:mobile_notes_app/notes/data/models/task.dart';
import 'package:mobile_notes_app/notes/data/models/tag.dart';
import 'package:mobile_notes_app/notes/data/models/note.dart';

class FirestoreDataSource extends DataSource {
  @override
  Future<void> addNote(Note note) async {
    // TODO: implement addNote
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('notes')
        .doc(uid)
        .collection('user_notes')
        .doc(note.id)
        .set(note.toJson());
  }

  @override
  Future<void> addTag(Tag tag) {
    // TODO: implement addTag
    throw UnimplementedError();
  }

  @override
  Future<void> addTask(String noteId, Task task) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<void> deleteNote(String id) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTag(String title) {
    // TODO: implement deleteTag
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTask(String noteId, Task task) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<List<Note>> loadNotes() {
    // TODO: implement loadNotes
    throw UnimplementedError();
  }

  @override
  Future<List<Tag>> loadTags() {
    // TODO: implement loadTags
    throw UnimplementedError();
  }

  @override
  Future<void> updateNote(Note note, String? id) async {
    // TODO: implement updateNote
    await addNote(note);
  }

  @override
  Future<void> updateTag(Tag tag, String title) {
    // TODO: implement updateTag
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(String noteId, Task oldTask, Task newTask) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
