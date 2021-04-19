import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mobile_notes_app/data/data_sources/hive_db.dart';
import 'package:mobile_notes_app/data/models/note.dart';
import 'package:mobile_notes_app/data/models/tag.dart';
import 'package:mobile_notes_app/data/models/task.dart';
import 'package:mobile_notes_app/notes/bloc/notes_bloc.dart';
import 'package:mobile_notes_app/ui/note_card.dart';
import 'package:mobile_notes_app/ui/themes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesBloc>(
      create: (context) => NotesBloc(
        repository: HiveDatabase(
          notesBox: Hive.box('notesBox'),
        ),
      ),
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: Themes.darkTheme,
        home: SafeArea(
          child: Scaffold(
            backgroundColor: Themes.noteColours['black'],
            bottomNavigationBar: const BottomAppBar(
              color: Themes.darkBackgroundColor,
              child: Text('Bottom App Bar'),
            ),
            // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Themes.noteColours['blue'],
              onPressed: null,
              child: const Icon(Icons.add),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: BlocBuilder<NotesBloc, NotesState>(
                    builder: (context, state) {
                      if (state is NotesLoading)
                        return const CircularProgressIndicator();
                      if (state is NotesLoadSuccess) {
                        var notes = state.notes;
                        if (notes.isEmpty)
                          return Container(
                            child: const Text('No notes found'),
                          );
                        return ListView.builder(
                          itemCount: notes.length,
                          itemBuilder: (context, index) => NoteCard(
                            note: notes[index],
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
                Builder(
                  builder: (context) => TextButton(
                    onPressed: () {
                      context.read<NotesBloc>().add(
                            NoteUpdated(
                              Note(
                                  title: 'Similarity',
                                  body:
                                      '''Elements that share similar properties are perceived as more related.\n\nAny number of characteristics can be similar: colour, shape, size, texture, etc.''',
                                  id: '1',
                                  dateTime: DateTime.now(),
                                  tags: const [
                                    Tag(title: 'Design'),
                                  ],
                                  tasks: const [
                                    Task(body: 'Test task', isCompleted: true),
                                  ]),
                            ),
                          );
                    },
                    child: const Text('Press'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
