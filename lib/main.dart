import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_notes_app/app.dart';
import 'package:mobile_notes_app/data/data_sources/hive_db.dart';
import 'package:mobile_notes_app/data/models/note.dart';
import 'package:mobile_notes_app/data/models/tag.dart';
import 'package:mobile_notes_app/data/models/task.dart';

import 'notes/bloc/notes_bloc.dart';

void main() async {
  Hive
    ..registerAdapter(NoteAdapter())
    ..registerAdapter(TagAdapter())
    ..registerAdapter(TaskAdapter());

  await Hive.initFlutter();
  await Hive.openBox<Note>('notesBox');
  await Hive.openBox<Tag>('tagsBox');
  await Hive.openBox<Task>('tasksBox');

  runApp(
    BlocProvider<NotesBloc>(
      create: (context) => NotesBloc(
        repository: HiveDatabase(
          notesBox: Hive.box('notesBox'),
        ),
      ),
      child: const App(),
    ),
  );
}
