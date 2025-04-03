import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  bool emailVerified;

  AuthUser(
    this.emailVerified
    );
    
    factory AuthUser.fromFirebase(User user) {
      return AuthUser(user.emailVerified);
    }
}
