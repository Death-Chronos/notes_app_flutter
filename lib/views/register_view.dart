import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:notes_app/constant/routes.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/utilities/show_dialogs.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
      appBar: AppBar(
        title: const Text("Registrar"),
        backgroundColor: Colors.blue,
      ),
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
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  await showErrorDialog(context, 'A senha que informou é fraca');
                } else if (e.code == 'email-already-in-use') {
                  await showErrorDialog(context, 'O email que informou já está em uso');
                } else if (e.code == 'invalid-email') {
                  await showErrorDialog(context, 'Email inválido');
                } else {
                  await showErrorDialog(context, 'Ocorreu um erro ao registrar: ${e.code}');
                }
              } catch (e) {
                await showErrorDialog(context, 'Ocorreu um erro inesperado: $e');
              }
            },
            child: const Text("Registrar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(
                loginRoute, 
                (route) => false);
            },
            child: const Text("Já tem uma conta? Faça login aqui"),
          ),
        ],
      ),
    );
  }
}
