import 'package:flutter/cupertino.dart';

@immutable
class CloudStorageException implements Exception {
  const CloudStorageException();
}

class CouldNotCreateNoteException extends CloudStorageException {
  const CouldNotCreateNoteException();

  @override
  String toString() => 'Não foi possível criar a anotação. Confira suas credenciais.';
}

class CouldNotGetAllNotesException extends CloudStorageException {
  const CouldNotGetAllNotesException();

  @override
  String toString() => 'Não foi possível obter todas as anotações.';
}

class CouldNotUpdateNoteException extends CloudStorageException {
  const CouldNotUpdateNoteException();

  @override
  String toString() => 'Não foi possível atualizar a anotação.';
}

class CouldNotDeleteNoteException extends CloudStorageException {
  const CouldNotDeleteNoteException();

  @override
  String toString() => 'Não foi possível deletar a anotação.';
}

class UserNotFoundException extends CloudStorageException {
  const UserNotFoundException();

  @override
  String toString() => 'Usuário não encontrado.';
}

