import 'package:mobile_notes_app/notes/data/data_sources/data_source.dart';
import 'package:mobile_notes_app/notes/data/models/note.dart';
import 'package:mobile_notes_app/notes/data/models/task.dart';
import 'package:mobile_notes_app/notes/data/models/tag.dart';
import 'package:mobile_notes_app/notes/data/repository/repository.dart';

class RepositoryImpl extends Repository {
  const RepositoryImpl({
    required DataSource localDataSource,
    required DataSource remoteDataSource,
  }) : super(
            localDataSource: localDataSource,
            remoteDataSource: remoteDataSource);

  // Note Functions
  @override
  Future<void> addNote(Note note) async {
    await localDataSource.addNote(note);
    await remoteDataSource.addNote(note);
  }

  @override
  Future<void> deleteNote(String id) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<void> updateNote(Note note, String? id) async {
    // TODO: implement updateNote
    await localDataSource.updateNote(note, id);
    await remoteDataSource.updateNote(note, id);
  }

  @override
  Future<List<Note>> loadNotes() async {
    //TODO: implement loadNotes
    return await localDataSource.loadNotes();
  }

  // Tag Functions
  @override
  Future<void> addTag(Tag tag) {
    // TODO: implement addTag
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

  @override
  Future<void> deleteTag(String title) {
    // TODO: implement deleteTag
    throw UnimplementedError();
  }

  // Task Functions
  @override
  Future<void> addTask(String noteId, Task task) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTask(String noteId, Task task) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(String noteId, Task oldTask, Task newTask) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
