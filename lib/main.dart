import 'package:flutter/material.dart';
import 'package:notes_app/constant/routes.dart';
import 'package:notes_app/services/auth/auth_service.dart';
import 'package:notes_app/views/login_view.dart';
import 'package:notes_app/views/notes/new_note_view.dart';
import 'package:notes_app/views/notes/notes_view.dart';
import 'package:notes_app/views/register_view.dart';
import 'package:notes_app/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      routes: {
        // Definindo as rotas do aplicativo
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        notesRoute: (context) => const NotesView(),
        newNoteRoute: (context) => const NewNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Inicializa o Firebase e aguarda a conclusão
      // O Firebase é inicializado no AuthService, que é um singleton
      future: AuthService.firebase().initialize(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // Verifica o estado da conexão, e de acordo com o estado, retorna a tela apropriada
        // Se o Firebase estiver inicializado, verifica se o usuário está logado e se o email está verificado
        // Se o usuário estiver logado e o email estiver verificado, retorna a tela de notas
        // Se o usuário não estiver logado, retorna a tela de login
        // Se o usuário estiver logado, mas o email não estiver verificado, retorna a tela de verificação de email
        // Se o Firebase não estiver inicializado, retorna uma tela de carregamento
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            } 
          default:
            return const Center(child: Text("Erro ao inicializar o Firebase"));
        }
        // Default return statement to handle all cases
      },
    );
  }
}
