import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:notes_app/services/auth/auth_user.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingText;
  const AuthState({
    required this.isLoading,
    this.loadingText = 'Por favor, aguarde um momento...',
  });
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required super.isLoading});
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering({
    required this.exception,
    required super.isLoading,
  });
}

class AuthStateForgotPassword extends AuthState {
  final Exception? exception;
  final bool hasSentEmail;
  const AuthStateForgotPassword({
    required this.exception,
    required this.hasSentEmail,
    required super.isLoading,
  });
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn({
    required this.user,
    required super.isLoading,
  });
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification({required super.isLoading});
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  const AuthStateLoggedOut({
    required this.exception,
    required super.isLoading,
    super.loadingText = null,
  });

  //Existem 3 'estados' de logout: 
  //logout normal(deslogado, excepetion null e isLoading false), 
  //logout com erro(Tentou logar e deu errado, exception existente e isLoading false) 
  //e tentando logar(isLoading true e exception null)
  //Por isso, o AuthStateLoggedOut é o único que tem o EquatableMixin, 
  //pois ele verifica as variaveis exception e isLoading para descidir se o estado(O objeto) 
  //é realmente igual entre outro objeto de mesma classe
  @override
  List<Object?> get props => [exception, isLoading];
}