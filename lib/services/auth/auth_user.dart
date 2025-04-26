import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final String id;
  final String email;
  final bool emailVerified;

  const AuthUser({
    required this.id,
    required this.email,
    required this.emailVerified
    });
    
    factory AuthUser.fromFirebase(User user) {
      return AuthUser(
        id: user.uid,
        email: user.email!, 
        emailVerified: user.emailVerified,);
    }
}
