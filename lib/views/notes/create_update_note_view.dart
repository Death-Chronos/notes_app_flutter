import 'package:flutter/material.dart';
import 'package:notes_app/services/auth/auth_service.dart';
import 'package:notes_app/services/cloud/cloud_note.dart';
import 'package:notes_app/services/cloud/firebase_cloud_storage.dart';
import 'package:notes_app/utilities/generics/get_arguments.dart';
import 'dart:developer' as dev show log;

class CreateUpdateNoteView extends StatefulWidget {
  const CreateUpdateNoteView({super.key});

  @override
  CreateUpdateNoteViewState createState() => CreateUpdateNoteViewState();
}

class CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {
  CloudNote? _note;
  late final FirebaseCloudStorage _notesService;
  late final TextEditingController _textController;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    _textController = TextEditingController();
    super.initState();
  }

  // Cria um Listenner para o TextController, que é o campo de texto onde o usuário digita a anotação.
  // O Listenner deve ser chamado sempre que o texto do campo de texto muda, pois é ele quem atualiza a anotação no banco de dados.
  void _textControllerListener() {
    final note = _note;
    if (note == null) {
      return;
    } else {
      _notesService.updateNote(
        documentId: note.documentId,
        text: _textController.text,
      );
    }
  }

  //Define o Listenner para o TextController. Ele remove o Listenner anterior e adiciona um novo Listenner, pois a função pode ser chamada muitas vezes.
  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  //Cria uma nova anotação caso não exista, se existir, manda a existente.
  Future<CloudNote> createOrGetExistingNote(BuildContext context) async {
    final widgetNote = context.getArgument<CloudNote>();

    
    if (widgetNote != null) {
      _note = widgetNote;
      _textController.text = widgetNote.text;
      return widgetNote;
    }

    final existingNotes = _note;
    if (existingNotes != null) {
      return existingNotes;
    } 
    else {
      final currentUser = AuthService.firebase().currentUser!;
      final userId = currentUser.id;
      final newNote = await _notesService.createNewNote(ownerUserId: userId);
      _note = newNote;
      return newNote;
    }
  }

  //Deleta a anotação se o texto estiver vazio
  void _deleteNoteIfTextIsEmpty() {
    final note = _note;
    if (_textController.text.isEmpty && note != null) {
      _notesService.deleteNote(documentId: note.documentId);
    }
  }

  //Atualiza a anotação se o texto não estiver vazio. Como a maioria dos apps de anotação, ele salva automaticamente, não precisando de um botão de salvar.
  Future<void> _saveNoteIfTextIsNotEmpty() async {
    final note = _note;
    if (_textController.text.isNotEmpty && note != null) {
      await _notesService.updateNote(
        documentId: note.documentId,
        text: _textController.text,
      );
    }
  }

  @override
  void dispose() {
    // Ao sair da tela, ele deleta a anotação se o texto estiver vazio e salva a anotação se o texto não estiver vazio.
    // Isso é feito para evitar que o usuário tenha que clicar em um botão de salvar.
    _deleteNoteIfTextIsEmpty();
    _saveNoteIfTextIsNotEmpty();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova Anotação"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: createOrGetExistingNote(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              _setupTextControllerListener();
              return TextField(
                controller: _textController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: "Digite sua anotação aqui...",
                  border: InputBorder.none,
                ),
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
