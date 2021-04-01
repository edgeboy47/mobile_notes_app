import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_notes_app/app.dart';
import 'package:mobile_notes_app/data/models/note.dart';

void main() async {
  Hive.registerAdapter(NoteAdapter());
  await Hive.initFlutter();
  await Hive.openBox<Note>('notesBox');
  
  runApp(const App());
}
