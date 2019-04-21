import 'package:flutter/material.dart';
import './lista_disciplinas.dart';
import './form_disciplina.dart';
import './obj_disciplina.dart';
import 'view_disciplina.dart';

void main() {
  Container cont = new Container();
 List<Container> lista = [cont];
 Disciplina disciplina;
  runApp(
    MaterialApp(
      title: "Organizer",
      home: ListaDisciplinas(lista: lista),
    
    ),
  );
}
