import 'package:flutter/material.dart';
import 'package:notes_app/enums/menu_action.dart';

class NotesView extends StatefulWidget {
  const NotesView({ Key? key }) : super(key: key);

  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Suas anotações"),
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) {
            switch (value) {
              case MenuAction.logout:
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login/',
                  (route) => false,
                );
                break;
            }
          },itemBuilder: (context) {
            return [
              const PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text("Sair"),
              ),
            ];
          },)
        ],
      ),
      body: const Center(
        child: Text("Anotações"),
      ),
    );
  }
}