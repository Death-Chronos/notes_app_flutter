import 'auth_user.dart';

abstract class AuthProvider {

  Future<void> initialize();
  AuthUser? get currentUser;

  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<void> sendEmailVerification();
  Future<void> logOut();
  Future<void> sendPasswordReset({required String toEmail});
}