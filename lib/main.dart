import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_notes_app/app.dart';
import 'package:mobile_notes_app/notes/data/models/note.dart';
import 'package:mobile_notes_app/notes/data/models/tag.dart';
import 'package:mobile_notes_app/notes/data/models/task.dart';

void main() async {
  Hive
    ..registerAdapter(NoteAdapter())
    ..registerAdapter(TagAdapter())
    ..registerAdapter(TaskAdapter());

  await Hive.initFlutter();
  await Hive.openBox<Note>('notesBox');
  await Hive.openBox<Tag>('tagsBox');
  await Hive.openBox<Task>('tasksBox');

  await Firebase.initializeApp();

  runApp(App());
}
