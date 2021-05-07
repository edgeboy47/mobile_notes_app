import 'package:flutter/material.dart';
import 'package:mobile_notes_app/data/models/note.dart';
import 'package:mobile_notes_app/data/models/tag.dart';
import 'package:mobile_notes_app/ui/note_page.dart';
import 'package:mobile_notes_app/ui/themes.dart';
import 'package:mobile_notes_app/utils.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({Key? key, required this.note}) : super(key: key);

  final Note note;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NotePage(note: note),
            ),
          );
        },
        //TODO: Add hero animation onpress
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(12),
            width: MediaQuery.of(context).size.width * 0.5,
            color: Themes.darkBackgroundColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: note.title.isNotEmpty
                      ? Text(
                          note.title,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: Themes.noteCardTitle,
                        )
                      : Container(),
                ),
                Flexible(
                  child: note.body.isNotEmpty
                      ? Text(
                          note.body,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: Themes.noteCardBody,
                        )
                      : Container(),
                ),
                Flexible(
                  child: (note.tasks != null && note.tasks!.isNotEmpty)
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: note.tasks!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index > 12) return Container();
                            if (index == 12) return const Text('...');
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: note.tasks![index].isCompleted,
                                  onChanged: null,
                                ),
                                Flexible(
                                  child: Text(
                                    note.tasks![index].body,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      : Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (note.tags != null) ...note.tags!.map(_tag),
                    Text(
                      formattedDate(note),
                      style: Themes.noteCardDate,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tag(Tag tag) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Themes.tagBorderColour,
        ),
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(10),
          right: Radius.circular(10),
        ),
      ),
      child: Text(
        tag.title,
        style: Themes.noteCardDate,
      ),
    );
  }
}
