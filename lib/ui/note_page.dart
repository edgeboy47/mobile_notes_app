import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_notes_app/data/models/note.dart';
import 'package:mobile_notes_app/notes/bloc/notes_bloc.dart';
import 'package:mobile_notes_app/ui/themes.dart';
import 'package:mobile_notes_app/utils.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Themes.noteColours['blue'],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Toolbar(
                  note: widget.note,
                  titleController: titleController,
                  bodyController: bodyController,
                ),
                Expanded(
                  child: NoteForm(
                    note: widget.note,
                    titleController: titleController,
                    bodyController: bodyController,
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

class NoteForm extends StatelessWidget {
  const NoteForm({
    Key? key,
    required this.note,
    required this.titleController,
    required this.bodyController,
  }) : super(key: key);

  final Note note;
  final TextEditingController titleController;
  final TextEditingController bodyController;

  @override
  Widget build(BuildContext context) {
    titleController.text = note.title;
    bodyController.text = note.body;

    return Form(
      child: ListView(
        children: [
          TextFormField(
            controller: titleController,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: 'Title',
              border: InputBorder.none,
            ),
            style: Themes.notePageHeader,
          ),
          BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              var thisNote = note;
              if (state is NotesLoadSuccess) {
                thisNote = state.notes
                    .where((element) => element.id == note.id)
                    .single;
              }
              return Text(
                'Updated ${formattedDate(thisNote)}',
              );
            },
          ),
          TextFormField(
            controller: bodyController,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: 'Note',
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}

class Toolbar extends StatelessWidget {
  const Toolbar({
    Key? key,
    required this.note,
    required this.titleController,
    required this.bodyController,
  }) : super(key: key);

  final Note note;
  final TextEditingController titleController;
  final TextEditingController bodyController;

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
          onPressed: () {
            final titleText = titleController.text;
            final bodyText = bodyController.text;

            context.read<NotesBloc>().add(
                  NoteUpdated(
                    note.copyWith(
                      title: titleText,
                      body: bodyText,
                      dateTime: DateTime.now(),
                    ),
                  ),
                );
          },
        ),
      ],
    );
  }
}
