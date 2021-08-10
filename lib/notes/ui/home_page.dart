import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile_notes_app/notes/application/bloc/notes_bloc.dart';
import 'package:mobile_notes_app/notes/data/models/note.dart';
import 'package:mobile_notes_app/notes/data/models/task.dart';
import 'package:mobile_notes_app/notes/ui/note_card.dart';
import 'package:mobile_notes_app/notes/ui/note_page.dart';
import 'package:mobile_notes_app/ui/themes.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  void _fabOnPress(BuildContext context) {
    final newNote = Note(
      body: '',
      title: '',
      dateTime: DateTime.now(),
    );

    context.read<NotesBloc>().add(NoteAdded(newNote));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NotePage(note: newNote),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Notes',
            style: Themes.noteCardTitle.copyWith(fontSize: 32),
          ),
        ),
        backgroundColor: Themes.noteColours['black'],
        bottomNavigationBar: const BottomNavBar(),
        floatingActionButtonLocation: const _CustomEndDockedFabLocation(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Themes.noteColours['blue'],
          onPressed: () => _fabOnPress(context),
          //TODO: Fab icon glow
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: SearchBar(),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: NoteGrid(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoteGrid extends StatelessWidget {
  const NoteGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state is NotesLoading) return const CircularProgressIndicator();
        if (state is NotesLoadSuccess) {
          var notes = state.notes;
          if (notes.isEmpty)
            return Center(
              child: Container(
                child: const Text('No notes found'),
              ),
            );
          return StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            itemCount: notes.length,
            itemBuilder: (context, index) => NoteCard(
              note: notes[index],
            ),
            staggeredTileBuilder: (_) => const StaggeredTile.fit(1),
          );
        }
        return Container();
      },
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: Themes.darkBackgroundColor,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () {
                  //TODO: Implement filtering feature
                },
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  //TODO: Implement search feature
                  maxLines: 1,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search your notes',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: const Icon(Icons.view_agenda_outlined),
                onPressed: () {
                  //TODO: Implement table/grid view switch feature
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
      child: BottomAppBar(
        notchMargin: 6,
        shape: const CircularNotchedRectangle(),
        color: Themes.darkBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: IconButton(
                  icon: const Icon(Icons.check_circle_outline),
                  onPressed: () {
                    final newNote = Note(
                      body: '',
                      title: '',
                      dateTime: DateTime.now(),
                      tasks: const [Task(body: '', isCompleted: false)],
                    );

                    context.read<NotesBloc>().add(NoteAdded(newNote));

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NotePage(
                          note: newNote,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: IconButton(
                  icon: const Icon(Icons.mic_outlined),
                  onPressed: () {
                    //TODO: Implement voice recording feature
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: IconButton(
                  icon: const Icon(Icons.camera_alt_outlined),
                  onPressed: () {
                    //TODO: Implement camera/gallery feature
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: IconButton(
                  icon: const Icon(Icons.brush_outlined),
                  onPressed: () {
                    //TODO: Implement drawing feature
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomEndDockedFabLocation extends StandardFabLocation
    with FabMiniOffsetAdjustment, FabEndOffsetX, FabDockedOffsetY {
  const _CustomEndDockedFabLocation();

  @override
  double getOffsetX(
          ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) =>
      super.getOffsetX(scaffoldGeometry, adjustment) - 30.0;

  @override
  String toString() => 'FloatingActionButtonLocation.miniEndDocked';
}
