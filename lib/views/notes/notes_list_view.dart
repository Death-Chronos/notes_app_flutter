import 'package:flutter/material.dart';
import 'package:notes_app/services/cloud/cloud_note.dart';
import 'package:notes_app/utilities/dialogs/show_dialogs.dart';

//Guarda funções de callback para serem chamadas quando o usuário clicar em um item da lista, como as funções de deletar ou editar uma nota(as funções são passadas no notes_view).
typedef NoteCallback = void Function(CloudNote note);

class NotesListView extends StatelessWidget {
  final Iterable<CloudNote> notes;
  final NoteCallback onDeleteNote;
  final NoteCallback onTap;

  const NotesListView({
    super.key,
    required this.notes,
    required this.onDeleteNote,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final note = notes.elementAt(index);
        return ListTile(
          onTap: () {
            onTap(note);
          },
          title: Text(
            note.text,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteNoteDialog(context, note);
              if (shouldDelete) {
                onDeleteNote(note);
              }
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
      itemCount: notes.length,
    );
  }
}
