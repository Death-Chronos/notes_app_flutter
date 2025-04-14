import 'package:flutter/material.dart';

class NewNoteView extends StatefulWidget {
  const NewNoteView({ super.key });

  @override
  _NewNoteViewState createState() => _NewNoteViewState();
}

class _NewNoteViewState extends State<NewNoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova Anotação"),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text("Escreva a sua nova anotação aqui!"),
      ),
    );
  }
}