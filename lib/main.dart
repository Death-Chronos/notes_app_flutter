// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/firebase_options.dart';
// ignore: unused_import
import 'package:notes_app/views/login_view.dart';
// ignore: unused_import
import 'package:notes_app/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            // final user = FirebaseAuth.instance.currentUser;
            // print(user);
            // final emailVerified = user?.emailVerified ?? false;
            // if (emailVerified) {
            //   return const Text("Feito");
            // } else {
            //   return const VerifyEmailView();
            // }
            return const LoginView();
          case ConnectionState.none:
            return const Center(child: Text("Firebase não inicializado"));
          default:
            return const Center(child: Text("Erro ao inicializar o Firebase"));
        }
        // Default return statement to handle all cases
      },
    );
  }
}
