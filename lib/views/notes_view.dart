import 'package:flutter/material.dart';
import 'package:notes_app/constant/routes.dart';
import 'package:notes_app/enums/menu_action.dart';
import 'package:notes_app/services/auth/auth_service.dart';
import 'package:notes_app/services/crud/notes_service.dart';
import 'package:notes_app/utilities/dialogs/show_dialogs.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  NotesViewState createState() => NotesViewState();
}

class NotesViewState extends State<NotesView> {
  late final NotesService _notesService;
  String get userEmail => AuthService.firebase().currentUser!.email;

  // ao iniciar a página
  @override
  initState() {
    _notesService = NotesService();
    super.initState();
  }

  //ao fechar o widget
  @override
  void dispose() {
    _notesService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Suas anotações"),
        backgroundColor: Colors.blue,
        actions: [
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
      body: FutureBuilder(
        future: _notesService.getOrCreateUser(email: userEmail),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return StreamBuilder(
                stream: _notesService.allNotes,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: Text("Carregando todas as anotações"),
                      );
                    default:
                      return const CircularProgressIndicator();
                  }
                },
              );
            default:
              return const Text("batata");
          }
        },
      ),
    );
  }
}
