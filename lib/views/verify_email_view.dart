import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/services/auth/bloc/auth_bloc.dart';
import 'package:notes_app/services/auth/bloc/auth_event.dart';


class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  VerifyEmailViewState createState() => VerifyEmailViewState();
}
  
class VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verificação de Email"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              context.read<AuthBloc>().add(
                const AuthEventLogOut(),
              );
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
                
                context.read()<AuthBloc>().add(
                  const AuthEventSendEmailVerification(),
                );
              },
              child: const Text("Caso não tenha recebido, clique aqui para enviar outro Email de Verificação"),
            ),
          ],
        ),
      ),
    );
  }
}
