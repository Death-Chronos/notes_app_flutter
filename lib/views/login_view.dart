import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:notes_app/constant/routes.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/utilities/show_dialogs.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"), backgroundColor: Colors.blue),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Digite o seu email",
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: "Senha",
              hintText: "Digite a sua senha",
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                final user = userCredential.user;

                if (user?.emailVerified?? false) {
                  Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(notesRoute, (route) => false);
                } else {
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil(verifyEmailRoute, (route) => false); 
                }    
                

              } on FirebaseAuthException catch (e) {
                if (e.code == 'invalid-credential') {
                  await showErrorDialog(context, 'Email ou senha inválidos');
                }
              } catch (e) {
                await showErrorDialog(context, 'Erro ao realizar o login');
              }
            },
            style: TextButton.styleFrom(backgroundColor: Colors.purple[600]),
            child: const Text(
              "Login", 
              style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text("Não se registrou ainda? Registre-se aqui."),
          ),
        ],
      ),
    );
  }
}


