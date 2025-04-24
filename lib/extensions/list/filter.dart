extension Filter<T> on Stream<List<T>>{

  Stream<List<T>> filter(bool Function(T) where) =>
    map((items)=> items.where(where).toList());
}
//Cria um filtro para o stream de listas(lsita de anotações, no nosso caso), que espera uma função de filtro que retorna um booleano, e aplica essa função a cada item do stream, retornando uma lista filtrada.