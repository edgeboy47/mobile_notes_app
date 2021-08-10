import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_notes_app/notes/application/bloc/notes_bloc.dart';
import 'package:mobile_notes_app/notes/data/models/task.dart';

class TaskTile extends FormField<Task> {
  TaskTile({
    Key? key,
    required this.id,
    required this.task,
    FormFieldSetter<Task>? onSaved,
    FormFieldValidator<Task>? validator,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: task,
          builder: (FormFieldState<Task> state) {
            var updatedTask = state.value!;

            return ListTile(
              leading: Checkbox(
                activeColor: Colors.white,
                checkColor: Colors.black,
                shape: const CircleBorder(),
                value: state.value!.isCompleted,
                onChanged: (value) {
                  updatedTask = updatedTask.copyWith(isCompleted: value);
                  state.didChange(updatedTask);
                },
              ),
              title: TextFormField(
                maxLines: null,
                initialValue: state.value!.body,
                onChanged: (value) {
                  updatedTask = updatedTask.copyWith(body: value);
                  state.didChange(updatedTask);
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
              trailing: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    context.read<NotesBloc>().add(NoteTaskDeleted(id, task));
                  },
                ),
              ),
            );
          },
        );

  final Task task;
  final String id;
}
