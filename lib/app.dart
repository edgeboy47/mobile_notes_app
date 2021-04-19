import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_notes_app/data/models/note.dart';
import 'package:mobile_notes_app/data/models/tag.dart';
import 'package:mobile_notes_app/data/models/task.dart';
import 'package:mobile_notes_app/notes/bloc/notes_bloc.dart';
import 'package:mobile_notes_app/ui/note_card.dart';
import 'package:mobile_notes_app/ui/note_page.dart';
import 'package:mobile_notes_app/ui/themes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: Themes.darkTheme,
      home: SafeArea(
        child: Builder(
          builder: (context) => Scaffold(
            backgroundColor: Themes.noteColours['black'],
            bottomNavigationBar: const BottomAppBar(
              color: Themes.darkBackgroundColor,
              child: Text('Bottom App Bar'),
            ),
            // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Themes.noteColours['blue'],
              onPressed: () {
                final newNote = Note(
                  body: '',
                  title: '',
                  dateTime: DateTime.now(),
                  id: '2',
                );

                context.read<NotesBloc>().add(NoteAdded(newNote));

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NotePage(note: newNote),
                  ),
                );
              },
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
