import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mobile_notes_app/notes/application/bloc/notes_bloc.dart';
import 'package:mobile_notes_app/notes/data/data_sources/hive_db.dart';
import 'package:mobile_notes_app/notes/ui/home_page.dart';
import 'package:mobile_notes_app/ui/themes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesBloc>(
      create: (context) => NotesBloc(
        repository: HiveDatabase(
          notesBox: Hive.box('notesBox'),
          tagsBox: Hive.box('tagsBox'),
        ),
      ),
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: Themes.darkTheme,
        home: const HomePage(),
      ),
    );
  }
}
