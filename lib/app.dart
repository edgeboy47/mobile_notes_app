import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mobile_notes_app/data/data_sources/hive_db.dart';
import 'package:mobile_notes_app/data/models/note.dart';
import 'package:mobile_notes_app/data/models/tag.dart';
import 'package:mobile_notes_app/data/models/task.dart';
import 'package:mobile_notes_app/notes/bloc/notes_bloc.dart';
import 'package:mobile_notes_app/ui/themes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: Themes.darkTheme,
      home: Scaffold(
        body: SafeArea(
          child: BlocProvider<NotesBloc>(
            create: (context) => NotesBloc(
              repository: HiveDatabase(
                notesBox: Hive.box('notesBox'),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                ));
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
                                  body: '''
                                      Elements that share similar properties are perceived as more related.
                                      Any number of characteristics can be similar: colour, shape, size, texture, etc.
                                      ''',
                                  id: '1',
                                  dateTime: DateTime.now(),
                                  tags: const [
                                    Tag(title: 'Test tag2'),
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

class NoteCard extends StatelessWidget {
  const NoteCard({Key? key, required this.note}) : super(key: key);

  final Note note;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          color: const Color(0xFF171C26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: [
              Text(
                note.title,
                style: Themes.noteCardTitle,
              ),
              Text(
                note.body,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (note.tags != null)
                    ...note.tags!.map((e) => Text(e.title)).toList(),
                  Text('${note.dateTime.day}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
