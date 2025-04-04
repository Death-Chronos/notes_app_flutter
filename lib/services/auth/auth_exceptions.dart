//Exceções de login
class InvalidCredencialAuthException implements Exception {
  const InvalidCredencialAuthException();

  @override
  String toString() => 'Email ou senha inválidas.';
}

// Exceções de registro
class WeakPasswordAuthException implements Exception {
  const WeakPasswordAuthException();

  @override
  String toString() =>
      'Senha fraca. Deve conter ao menos 6 caracteres.';
}

class EmailAlreadyInUseAuthException implements Exception {
  const EmailAlreadyInUseAuthException();

  @override
  String toString() => 'Email já está em uso.';
}

class InvalidEmailAuthException implements Exception {
  const InvalidEmailAuthException();

  @override
  String toString() => 'Email inválido.';
}

//Exceções genericas
class GenericAuthException implements Exception {
  const GenericAuthException();

  @override
  String toString() => 'Ocorreu um erro inesperado.';
}

class UserNotLoggedInAuthException implements Exception {
  const UserNotLoggedInAuthException();
  @override
  String toString() => 'Você não está logado.';
}
