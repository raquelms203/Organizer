import 'package:flutter/material.dart';
import './lista_disciplinas.dart';
import './add_disciplina.dart';
import 'view_disciplina.dart';

void main() {
  Container cont = new Container();
 List<Container> lista = [cont];
  runApp(
    MaterialApp(
      title: "Organizer",
     // home: ListaDisciplinas(lista: lista),
     home: ListaDisciplinas(lista: lista),
    ),
  );
}
