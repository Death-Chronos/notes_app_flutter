import 'package:flutter/material.dart' show BuildContext, ModalRoute;

//Usando esse método, você pode extrair o argumento de qualquer widget que tenha um ModalRoute, como o Navigator, por exemplo.
//Isso é útil para passar dados entre telas, como o ID de um usuário ou uma anotação específica.
//Exemplo, eu passo um id de anotação para outra tela, e só no método de pegar, eu usar um getArgument<int>() para pegar o id,
// e não preciso me preocupar com o tipo de dado que estou passando, pois o método já faz isso por mim. 
//Assim, posso criar um só metodo para pegar qualquer tipo de dado passado de uma tela para outra.
extension GetArgument on BuildContext{
   T? getArgument<T>(){
    final modalRoute = ModalRoute.of(this);

    if(modalRoute != null){
      final args = modalRoute.settings.arguments;
      if(args is T){
        return args;
      }
    }
    return null;
  }
}