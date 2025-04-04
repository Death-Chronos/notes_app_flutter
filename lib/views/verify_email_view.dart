import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:notes_app/constant/routes.dart';
import 'package:notes_app/services/auth/auth_service.dart';


class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  _VerifyEmailViewState createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verificação de Email"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
          ),
        ],
      ),
      body: Center( // Wrap the Column with Center
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ensure the Column takes minimal vertical space
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // Center the text vertically and horizontally
          children: [
            const Text("Mandamos um E-mail de Verificação, verique seu email para continuar"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final user = AuthService.firebase().currentUser;
                devtools.log(user.toString());
                await AuthService.firebase().sendEmailVerification();
              },
              child: const Text("Caso não tenha recebido, clique aqui para enviar outro Email de Verificação"),
            ),
          ],
        ),
      ),
    );
  }
}
