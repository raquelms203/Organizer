import 'package:flutter/material.dart';
import './lista_disciplinas.dart';

void main() {
  Container cont = new Container();
 List<Container> lista = [cont];
  runApp(
    MaterialApp(
      title: "Organizer",
      home: ListaDisciplinas(lista: lista),
    
    ),
  );
}