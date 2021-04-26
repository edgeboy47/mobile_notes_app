import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_notes_app/data/models/note.dart';
import 'package:mobile_notes_app/notes/bloc/notes_bloc.dart';
import 'package:mobile_notes_app/ui/themes.dart';
import 'package:mobile_notes_app/utils.dart';
import 'package:uuid/uuid.dart';

class NotePage extends StatelessWidget {
  const NotePage({Key? key, required this.note}) : super(key: key);

  final Note note;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Themes.noteColours['blue'],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Toolbar(
                    note: note,
                  ),
                  Expanded(
                    child: NoteForm(
                      note: note,
                    ),
                  ),
                  BottomToolbar(note: note)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomToolbar extends StatelessWidget {
  const BottomToolbar({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.add_box_outlined),
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Themes.darkBackgroundColor,
              elevation: 5,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.add_a_photo_outlined),
                        title: const Text('Take photo'),
                        onTap: () {
                          //TODO: Implement adding photo to current note
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.photo),
                        title: const Text('Add photo'),
                        onTap: () {
                          //TODO: Implement addding photo from gallery
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.brush_outlined),
                        title: const Text('Drawing'),
                        onTap: () {
                          //TODO: Implement adding drawing
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.mic_none_outlined),
                        title: const Text('Recording'),
                        onTap: () {
                          // TODO: Implement adding recording feature
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.check_box_outlined),
                        title: const Text('Checkboxes'),
                        onTap: () {
                          //TODO: Implement adding checkboxes
                        },
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Themes.darkBackgroundColor,
              elevation: 5,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.delete),
                        title: const Text('Delete note'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          context.read<NotesBloc>().add(NoteDeleted(note.id!));
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.copy),
                        title: const Text('Make a copy'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          context.read<NotesBloc>().add(
                                NoteAdded(
                                  note.copyWith(
                                    dateTime: DateTime.now(),
                                    id: const Uuid().v1(),
                                  ),
                                ),
                              );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.share),
                        title: const Text('Share'),
                        onTap: () {
                          //TODO: Implement share feature
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.label),
                        title: const Text('Labels'),
                        onTap: () {
                          // TODO: Implement tags feature
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class NoteForm extends StatelessWidget {
  const NoteForm({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
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
            var thisNote = note;
            if (state is NotesLoadSuccess) {
              var filteredList =
                  state.notes.where((element) => element.id == note.id);
              if (filteredList.isEmpty == false) thisNote = filteredList.single;
            }
            return Text(
              'Updated ${formattedDate(thisNote)}',
              // style: Themes.noteCardBody.copyWith(fontSize: 16),
            );
          },
        ),
        note.tasks == null
            ? TextFormField(
                initialValue: note.body,
                onSaved: (String? val) {
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
              //TODO: Create UI for checklist
            : Container(
                child: Column(
                  children: [
                    ...note.tasks!
                        .map((el) => Row(
                              children: [
                                const Icon(Icons.drag_indicator),
                                Checkbox(
                                  value: el.isCompleted,
                                  onChanged: null,
                                ),
                                Flexible(
                                  child: TextFormField(
                                    initialValue: el.body,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.close)
                              ],
                            ))
                        .toList(),
                    ...note.tasks!.map(
                      (el) => ListTile(
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.drag_indicator),
                            Checkbox(
                              value: el.isCompleted,
                              onChanged: null,
                            ),
                          ],
                        ),
                        title: TextFormField(
                          initialValue: el.body,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                        trailing: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}

class Toolbar extends StatelessWidget {
  const Toolbar({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        const Icon(Icons.undo),
        const Icon(Icons.redo),
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: () => Form.of(context)!.save(),
        ),
      ],
    );
  }
}
