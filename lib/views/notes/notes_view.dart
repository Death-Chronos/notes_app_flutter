import 'package:flutter/material.dart';
import 'package:notes_app/constant/routes.dart';
import 'package:notes_app/enums/menu_action.dart';
import 'package:notes_app/services/auth/auth_service.dart';
import 'package:notes_app/services/cloud/cloud_note.dart';
import 'package:notes_app/services/cloud/firebase_cloud_storage.dart';
import 'package:notes_app/utilities/dialogs/show_dialogs.dart';
// import 'dart:developer' as dev show log;

import 'package:notes_app/views/notes/notes_list_view.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  NotesViewState createState() => NotesViewState();
}

class NotesViewState extends State<NotesView> {
  late final FirebaseCloudStorage _notesService;
  String get userId => AuthService.firebase().currentUser!.id;

  // ao iniciar a página
  @override
  initState() {
    _notesService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Suas anotações"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
            },
            icon: const Icon(Icons.add),
          ),
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogOut = await showLogOutDialog(context);
                  if (shouldLogOut) {
                    await AuthService.firebase().logOut();
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  }
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text("Sair"),
                ),
              ];
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _notesService.allNotes(ownerUserId: userId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: Text("Carregando todas as anotações"));
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allNotes = snapshot.data as Iterable<CloudNote>;
                return NotesListView(
                  notes: allNotes,
                  onDeleteNote: (note) async {
                    await _notesService.deleteNote(
                      documentId: note.documentId,
                    ); //note que aqui ele está passando a função que deve ser executada quando o usuário clicar no botão de deletar
                  },
                  onTap: (note) async {
                    Navigator.of(
                      context,
                    ).pushNamed(createOrUpdateNoteRoute, arguments: note);
                  },
                );

                // return const Text("Anotações carregadas com sucesso");
              } else {
                return const Center(child: Text("Nenhuma anotação encontrada"));
              }
            default:
              return const CircularProgressIndicator(color: Colors.redAccent);
          }
        },
      ),
    );
  }
}
