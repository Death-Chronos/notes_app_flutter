class CouldNotFindNote implements Exception {
  const CouldNotFindNote();

  @override
  String toString() => 'Nota não encontrada.';
}

class CouldNotDeleteNote  implements Exception {
  const CouldNotDeleteNote();

  @override
  String toString() => 'Não foi possível deletar a nota.';
}

class CouldNotFindUser implements Exception {
  const CouldNotFindUser();

  @override
  String toString() => 'Usuário não encontrado.';
}

class UserAlreadyExists implements Exception {
  const UserAlreadyExists();

  @override
  String toString() => 'Usuário já existe.';
}

class UnableToGetDocumentsDirectory implements Exception {
  const UnableToGetDocumentsDirectory();

  @override
  String toString() {
    return 'Não foi possível obter o diretório de documentos.';
  }
}

class DatabaseAlreadyOpenException implements Exception {
  const DatabaseAlreadyOpenException();

  @override
  String toString() => 'Banco de dados já está aberto.';
}

class DatabaseIsNotOpenException implements Exception {
  const DatabaseIsNotOpenException();

  @override
  String toString() => 'Banco de dados não está aberto.';
}
