import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_notes_app/notes/application/bloc/notes_bloc.dart';
import 'package:mobile_notes_app/notes/data/models/note.dart';
import 'package:mobile_notes_app/notes/data/models/task.dart';
import 'package:mobile_notes_app/ui/task_tile.dart';
import 'package:mobile_notes_app/ui/themes.dart';
import 'package:mobile_notes_app/utils.dart';

class NoteForm extends StatelessWidget {
  const NoteForm({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    // Used to prevent issues when updating multiple fields at once
    var newNote = note;

    return ListView(
      children: [
        TextFormField(
          initialValue: note.title,
          maxLines: null,
          style: Themes.notePageHeader,
          onSaved: (String? val) {
            if (val != null && val != newNote.title) {
              newNote = newNote.copyWith(
                title: val,
                dateTime: DateTime.now(),
              );
              context.read<NotesBloc>().add(NoteUpdated(newNote));
            }
          },
          decoration: const InputDecoration(
            hintText: 'Title',
            border: InputBorder.none,
          ),
        ),
        BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            // Prevents bad state error when the note is deleted
            var thisNote = note;
            if (state is NotesLoadSuccess) {
              var filteredList =
                  state.notes.where((element) => element.id == note.id);
              if (filteredList.isNotEmpty) thisNote = filteredList.single;
            }
            return Text(
              'Updated ${formattedDate(thisNote)}',
            );
          },
        ),
        BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            if (state is NotesLoadSuccess) {
              // Get current note from notes list
              var thisNote = note;
              var filteredList =
                  state.notes.where((element) => element.id == note.id);
              if (filteredList.isNotEmpty) thisNote = filteredList.single;

              return thisNote.tasks == null
                  ? TextFormField(
                      initialValue: thisNote.body,
                      onSaved: (String? val) {
                        // Prevent unnecessary calls to bloc
                        if (val != null && val != newNote.body) {
                          newNote = newNote.copyWith(
                            body: val,
                            dateTime: DateTime.now(),
                          );
                          context.read<NotesBloc>().add(NoteUpdated(newNote));
                        }
                      },
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Note',
                        border: InputBorder.none,
                      ),
                    )
                  : NoteFormTasks(note: thisNote);
            }
            return Container();
          },
        ),
      ],
    );
  }
}

class NoteFormTasks extends StatelessWidget {
  const NoteFormTasks({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              if (state is NotesLoadSuccess) {
                // final tasks = note.tasks;

                final filteredTasks = state.notes
                    .firstWhere((element) => element.id == note.id,
                        orElse: () => note)
                    .tasks;

                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filteredTasks!.length,
                  itemBuilder: (context, index) => TaskTile(
                    key: ValueKey(filteredTasks[index]),
                    id: note.id!,
                    task: filteredTasks[index],
                    onSaved: (Task? value) {
                      context.read<NotesBloc>().add(
                            NoteTaskUpdated(
                              id: note.id!,
                              oldTask: filteredTasks[index],
                              newTask: value!,
                            ),
                          );
                    },
                  ),
                );
              }
              return Container();
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            onTap: () {
              context.read<NotesBloc>().add(
                    NoteTaskAdded(
                      note.id!,
                      const Task(body: '', isCompleted: false),
                    ),
                  );
            },
            title: const Text('List Item'),
          )
        ],
      ),
    );
  }
}
