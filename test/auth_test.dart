import 'package:notes_app/services/auth/auth_exceptions.dart';
import 'package:notes_app/services/auth/auth_provider.dart';
import 'package:notes_app/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authenticantion', () {
    final auth = MockAuthProvider();

    test('Não deveria começar como inicializado', () {
      expect(auth.isInitialized, false);
    });

    test('Deveria ser possivel inicializar', () async {
      final auth = MockAuthProvider();
      await auth.initialize();
      expect(auth.isInitialized, true);
    });

    test('Não pode deslogar sem estar inicializado', () {
      expect(auth.logOut(), throwsA(isA<NotInitializedException>()));
    });

    test('Usuario deve ser nulo após a inicialização', (){
      
      expect(auth.currentUser, null);
    });

    test('Deveria inicializar antes de 2 segundos', () async {
      await auth.initialize();
      expect(auth.isInitialized, true);
    }, timeout: const Timeout(Duration(seconds: 2)));

    test('Criar um usuario deveria chamar a função de LogIn', () async {
      final badEmailOrPasswordUser = auth.createUser(
        email: 'jv@gmail.com', 
        password: '123456');

      expect(badEmailOrPasswordUser, throwsA(isA<InvalidCredencialAuthException>()));

      final user = await auth.createUser(email: 'teste@gmail.com', password: 'senha12345');
      expect(auth.currentUser, user);
      expect(user.emailVerified, false);
    });

    test('Usuario logado deveria ser capaz de verificar o login', (){
      auth.sendEmailVerification();
      final user = auth.currentUser;
      expect(user, isA<AuthUser>());
      expect(user!.emailVerified, true);
    });

    test('Deveria ser capaz de logar depois de fazer logout', (){

    });
  });
  
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInicialized = false;
  bool get isInitialized => _isInicialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!_isInicialized) {
      throw NotInitializedException();
    }
    await Future.delayed(const Duration(seconds: 2));

    return logIn(email: email, password: password);
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInicialized = true;
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    if (!_isInicialized) {
      throw NotInitializedException();
    }
    if (email == 'jv@gmail.com') throw InvalidCredencialAuthException();
    if (password == '123456') throw InvalidCredencialAuthException();
    const user = AuthUser(emailVerified: false);

    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!_isInicialized) throw NotInitializedException();
    if (_user == null) throw UserNotLoggedInAuthException();

    await Future.delayed(const Duration(seconds: 2));

    _user = null;
    return Future.value();
  }

  @override
  Future<void> sendEmailVerification() {
    if (!_isInicialized) throw NotInitializedException();
    if (_user == null) throw UserNotLoggedInAuthException();

    const user = AuthUser(emailVerified: true);
    _user = user;
    return Future.value();
  }
}
