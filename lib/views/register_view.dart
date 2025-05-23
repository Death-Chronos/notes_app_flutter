import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/services/auth/auth_exceptions.dart';
import 'package:notes_app/services/auth/bloc/auth_bloc.dart';
import 'package:notes_app/services/auth/bloc/auth_event.dart';
import 'package:notes_app/services/auth/bloc/auth_state.dart';
import 'package:notes_app/utilities/dialogs/show_dialogs.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateRegistering) {
          var e = state.exception;
          if (e is EmailAlreadyInUseAuthException) {
            showErrorDialog(
              context,
              e.toString(),
            );
          } else if (e is WeakPasswordAuthException) {
            showErrorDialog(
              context,
              e.toString(),
            );
          }
            else if (e is InvalidEmailAuthException) {
            showErrorDialog(
              context,
              e.toString(),
            );
          } else if (e is GenericAuthException) {
            showErrorDialog(
              context,
              e.toString(),
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Registrar"),
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Crie uma conta para começar a usar o aplicativo.",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                autofocus: true,
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
                    context.read<AuthBloc>().add(
                      AuthEventRegister(
                        email, 
                        password,
                      )
                    );
                },
                child: const Text("Registrar"),
              ),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEventLogOut());
                },
                child: const Text("Já tem uma conta? Faça login aqui"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
