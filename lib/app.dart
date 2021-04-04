import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_notes_app/data/data_sources/hive_db.dart';
import 'package:mobile_notes_app/data/models/note.dart';
import 'package:mobile_notes_app/data/models/tag.dart';
import 'package:mobile_notes_app/data/models/task.dart';
import 'package:mobile_notes_app/notes/bloc/notes_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: BlocProvider<NotesBloc>(
            create: (context) => NotesBloc(repository: HiveDatabase()),
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
                          itemBuilder: (context, index) => ListTile(
                            title: Text(notes[index].title),
                            subtitle: Text(notes[index].dateTime.toString()),
                            trailing: Text(notes[index].tags.toString()),
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
                            NoteAdded(
                              Note(
                                  title: 'Test',
                                  body: 'Test body',
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
