import 'package:mobile_notes_app/notes/data/data_sources/data_source.dart';
import 'package:mobile_notes_app/notes/data/models/note.dart';
import 'package:mobile_notes_app/notes/data/models/task.dart';
import 'package:mobile_notes_app/notes/data/models/tag.dart';
import 'package:mobile_notes_app/notes/data/repository/repository.dart';

class RepositoryImpl implements Repository {
  const RepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  //TODO: Add class to check connectivity before doing online actions
  // connectivity_plus package

  final DataSource localDataSource;
  final DataSource remoteDataSource;
  // Note Functions
  @override
  Future<void> addNote(Note note) async {
    // await localDataSource.addNote(note);
    await remoteDataSource.addNote(note);
  }

  @override
  Future<void> deleteNote(String id) async {
    // await localDataSource.deleteNote(id);
    await remoteDataSource.deleteNote(id);
  }

  @override
  Future<void> updateNote(Note note, String? id) async {
    // await localDataSource.updateNote(note, id);
    await remoteDataSource.updateNote(note, id);
  }

  @override
  Future<List<Note>> loadNotes() async {
    //TODO: sync local and remote sources on load, implement as Stream

    // If database is loaded, read from database, else read from online and
    // store in database
    return await remoteDataSource.loadNotes();
  }

  @override
  Future<List<Note>> loadNotesWithCompletedTasks() async {
    return remoteDataSource.loadNotesWithCompletedTasks();
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
  Future<void> addTask(String noteId, Task task) async {
    // await localDataSource.addTask(noteId, task);
    await remoteDataSource.addTask(noteId, task);
  }

  @override
  Future<void> deleteTask(String noteId, Task task) async {
    // await localDataSource.deleteTask(noteId, task);
    await remoteDataSource.deleteTask(noteId, task);
  }

  @override
  Future<void> updateTask(String noteId, Task oldTask, Task newTask) async {
    // await localDataSource.updateTask(noteId, oldTask, newTask);
    await remoteDataSource.updateTask(noteId, oldTask, newTask);
  }
}
