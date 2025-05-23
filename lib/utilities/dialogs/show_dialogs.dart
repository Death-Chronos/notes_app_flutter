import 'package:flutter/material.dart';
import 'package:notes_app/extensions/buildcontext/loc.dart';
import 'package:notes_app/services/cloud/cloud_note.dart';

//um map para as opções de botão, titulo e valor. por exemplo : 'deletar', true - 'cancelar', false
typedef DialogOptionBuilder<T> = Map<String, T> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();

  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions:
            options.keys.map((optionTitle) {
              final T value = options[optionTitle];
              return TextButton(
                onPressed: () {
                  if (value != null) {
                    Navigator.of(context).pop(value);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(optionTitle),
              );
            }).toList(),
      );
    },
  ); // Handle null case
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: "Sair",
    content: "Tem certeza que deseja sair?",
    optionsBuilder: () => {'Cancelar': false, 'Sair': true},
  ).then((value) => value ?? false);
}

Future<void> showErrorDialog(BuildContext context, String text) {
  return showGenericDialog(
    context: context,
    title: "Um erro ocorreu",
    content: text,
    optionsBuilder: () => {'Ok': null},
  );
}

Future<bool> showDeleteNoteDialog(BuildContext context, CloudNote note) {
  return showGenericDialog<bool>(
    context: context,
    title: "Deletar anotação",
    content: "Tem certeza que deseja deletar a anotação?",
    optionsBuilder: () => {'Cancelar': false, 'Deletar': true},
  ).then((value) => value ?? false);
}

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: "Erro ao compartilhar anotação",
    content: "Não é possível compartilhar uma anotação vazia",
    optionsBuilder: () => {'Ok': null},
  );
}

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: context.loc.password_reset,
    content: context.loc.password_reset_dialog_prompt,
    optionsBuilder: () => {
      context.loc.ok: null,
    },
  );
}